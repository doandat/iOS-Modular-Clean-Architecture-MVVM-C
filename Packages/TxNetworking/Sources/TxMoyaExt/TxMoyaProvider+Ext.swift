//
//  TxMoyaProvider+Ext.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Foundation
import Moya
import TxNetworkModels
import TxLogger
import SwiftyJSON

/// Extension providing additional functionality for MoyaProvider.
///
/// This extension adds methods for:
/// - Performing network requests with error handling
/// - Decoding responses into model objects
/// - Logging JSON responses in debug mode
public extension MoyaProvider {

    /// Performs a network request and returns the raw response data.
    ///
    /// This method:
    /// - Handles success and error cases
    /// - Logs JSON responses in debug mode
    /// - Converts HTTP status codes to appropriate errors
    /// - Handles various network error scenarios
    ///
    /// - Parameters:
    ///   - target: The target endpoint to request
    /// - Returns: The response data if successful
    /// - Throws: A TxResponseError if the request fails
    @discardableResult
    @MainActor
    func performRequest(target: Target) async throws -> Data {
        return try await withUnsafeThrowingContinuation { continuation in
            request(target) { result in
                switch result {
                case let .success(response):
#if DEBUG
                    response.logJSONResponse()
#endif
                    switch response.statusCode {
                    case 200 ... 299:
                        continuation.resume(returning: response.data)
                        return
                    default:
                        continuation.resume(throwing: Self.makeResponseError(response: response))
                    }
                case let .failure(moyaError):
#if DEBUG
                    TxLogger().error(moyaError)
#endif
                    switch moyaError {
                    case let .statusCode(response):
                        continuation.resume(throwing: Self.makeResponseError(response: response))
                    case .underlying(var nsError as NSError, let response):
                        if let afError = nsError.asAFError {
                            switch afError {
                            case .sessionTaskFailed(let error):
                                nsError = error as NSError
                            default:
                                break
                            }
                        }
                        guard nsError.domain == NSURLErrorDomain else {
                            let responseError = TxResponseError(
                                errorType: .network(.unknown),
                                message: "",
                                key: "",
                                responseCode: response?.statusCode,
                                otherError: moyaError
                            )
                            continuation.resume(throwing: responseError)
                            return
                        }
                        if nsError.code == NSURLErrorNotConnectedToInternet {
                            let responseError = TxResponseError(
                                errorType: .network(.noNetworkConnection),
                                message: "",
                                key: "",
                                responseCode: response?.statusCode,
                                otherError: moyaError
                            )
                            continuation.resume(throwing: responseError)
                        } else if nsError.code == NSURLErrorTimedOut {
                            let responseError = TxResponseError(
                                errorType: .network(.requestTimeout),
                                message: "",
                                key: "",
                                responseCode: response?.statusCode,
                                otherError: moyaError
                            )
                            continuation.resume(throwing: responseError)
                        } else {
                            let responseError = TxResponseError(
                                errorType: .network(.unknown),
                                message: "",
                                key: "",
                                responseCode: response?.statusCode,
                                otherError: moyaError
                            )
                            continuation.resume(throwing: responseError)
                        }
                    default:
                        let responseError = TxResponseError(
                            errorType: .server,
                            message: "",
                            key: "",
                            responseCode: nil,
                            otherError: moyaError
                        )
                        continuation.resume(throwing: responseError)

                    }
                }
            }
        }
    }

    /// Performs a network request and decodes the response into a specified type.
    ///
    /// - Parameters:
    ///   - target: The target endpoint to request
    ///   - decoder: The JSON decoder to use (defaults to a new instance)
    /// - Returns: The decoded response object
    /// - Throws: A TxResponseError if the request fails or decoding fails
    @discardableResult
    @MainActor
    func performRequest<T: Decodable>(target: Target, decoder: JSONDecoder = .init()) async throws -> T {
        let data = try await performRequest(target: target)
        let result = try decoder.decode(T.self, from: data)
        return result
    }

    /// Creates a TxResponseError from a Moya response.
    ///
    /// This method:
    /// - Attempts to parse the response JSON
    /// - Extracts error information (key, message)
    /// - Creates an appropriate error type
    ///
    /// - Parameter response: The Moya response to process
    /// - Returns: A TxResponseError containing the error information
    static func makeResponseError(response: Response) -> TxResponseError {
        do {
            let jsonData = try response.mapJSON(failsOnEmptyData: false)
            let json = JSON(jsonData)
            if let key = json["key"].string {
                let message = json["message"].string
                let errorItem = TxResponseError(
                    errorType: .server,
                    message: message,
                    key: key,
                    responseCode: response.statusCode,
                    responseData: response.data
                )
                return errorItem
            } else if let message = json["message"].string {
                let errorItem = TxResponseError(
                    errorType: .server,
                    message: message,
                    key: nil,
                    responseCode: response.statusCode,
                    responseData: response.data
                )
                return errorItem
            } else {
                return TxResponseError(
                    errorType: .server,
                    responseCode: response.statusCode,
                    responseData: response.data
                )
            }
        } catch {
#if DEBUG
            TxLogger().error(error)
#endif
            return TxResponseError(
                errorType: .server,
                responseCode: response.statusCode,
                responseData: response.data
            )
        }
    }
}

/// Extension providing JSON pretty printing functionality for Data.
extension Data {
    /// Returns a pretty-printed JSON string representation of the data.
    ///
    /// - Returns: A formatted JSON string, or nil if the data cannot be converted
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return nil }
        return prettyPrintedString as String
    }
}

/// Extension providing JSON response logging functionality for Moya responses.
extension Response {
    /// Logs the JSON response in a formatted way.
    ///
    /// This method:
    /// - Attempts to parse the response data as JSON
    /// - Pretty prints the JSON for readability
    /// - Logs the result using TxLogger
    func logJSONResponse() {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self.data, options: .mutableContainers)
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            if let jsonString = String(data: prettyData, encoding: .utf8) {
                TxLogger().info("🔍 JSON Response:\n\(jsonString)")
            } else {
                TxLogger().debug("⚠️ Unable to convert data to String")
            }
        } catch {
            TxLogger().error("❌ Failed to parse JSON response: \(error.localizedDescription)")
        }
    }
}
