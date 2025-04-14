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

public extension MoyaProvider {

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

    @discardableResult
    @MainActor
    func performRequest<T: Decodable>(target: Target, decoder: JSONDecoder = .init()) async throws -> T {
        let data = try await performRequest(target: target)
        let result = try decoder.decode(T.self, from: data)
        return result
    }


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

extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return nil }
        return prettyPrintedString as String
    }
}

extension Response {
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
