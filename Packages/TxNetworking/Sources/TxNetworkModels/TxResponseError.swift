//
//  TxResponseError.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Foundation

/// A structure representing network and server errors in the application.
///
/// This struct provides detailed error information including:
/// - Error type classification
/// - Error messages
/// - Error codes
/// - Response data
/// - Debug information
public struct TxResponseError: LocalizedError {
    /// The type of error that occurred
    public let errorType: ErrorType
    
    /// A human-readable description of the error
    public let message: String?
    
    /// A unique identifier for the error type
    public let key: String?
    
    /// The HTTP status code or server response code
    public let responseCode: Int?
    
    /// Detailed error code from the server
    public let errorCode: Int?
    
    /// The raw response data from the server
    public let responseData: Data?
    
    /// The original error that caused this error
    public let otherError: Error?
    
    /// Detailed error description for debugging purposes
    public let debugDescription: String?

    /// Creates a new TxResponseError instance.
    ///
    /// - Parameters:
    ///   - errorType: The type of error
    ///   - message: Optional error message
    ///   - key: Optional error key
    ///   - responseCode: Optional HTTP status code
    ///   - errorCode: Optional detailed error code
    ///   - responseData: Optional response data
    ///   - otherError: Optional original error
    ///   - debugDescription: Optional debug description
    public init(
        errorType: ErrorType,
        message: String? = nil,
        key: String? = nil,
        responseCode: Int? = nil,
        errorCode: Int? = nil,
        responseData: Data? = nil,
        otherError: Error? = nil,
        debugDescription: String? = nil
    ) {
        self.errorType = errorType
        self.message = message
        self.key = key
        self.responseCode = responseCode
        self.errorCode = errorCode
        self.debugDescription = debugDescription
        self.responseData = responseData
        self.otherError = otherError
    }
}

extension TxResponseError {
    /// Enumeration defining the types of errors that can occur.
    public enum ErrorType: Sendable {
        /// Network-related errors
        case network(NetworkErrorType)
        
        /// Server-side errors (HTTP errors, API errors)
        case server
        
        /// Errors occurring during data decoding
        case decoding
        
        /// Unknown or unclassified errors
        case unknown
    }

    /// Enumeration defining specific network error types.
    public enum NetworkErrorType: Sendable {
        /// No network connection available
        case noNetworkConnection
        
        /// Request timed out
        case requestTimeout
        
        /// Unknown network error
        case unknown
    }

    /// Enumeration defining possible actions for network error alerts.
    public enum AlertActionNetworkError: Sendable {
        /// Retry the failed operation
        case retry
        
        /// Cancel the operation
        case cancel
    }
}
