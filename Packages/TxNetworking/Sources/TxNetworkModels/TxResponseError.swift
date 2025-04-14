//
//  TxResponseError.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Foundation

public struct TxResponseError: LocalizedError {
    public let errorType: ErrorType         // Loại lỗi (network, server, v.v.)
    public let message: String?             // Mô tả lỗi
    public let key: String?                 // Key định danh lỗi (có thể dùng để phân loại lỗi)
    public let responseCode: Int?           // Mã trạng thái HTTP hoặc mã lỗi trả về từ server
    public let errorCode: Int?              // Mã lỗi chi tiết từ server (nếu có)
    public let responseData: Data?
    public let otherError: Error?
    public let debugDescription: String?    // Mô tả lỗi chi tiết (dành cho debug)

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
    public enum ErrorType: Sendable{
        case network(NetworkErrorType)  // Lỗi kết nối mạng
        case server                 // Lỗi từ server (ví dụ: lỗi HTTP, lỗi từ API)
        case decoding             // Lỗi khi giải mã (decoding)
        case unknown               // Lỗi không xác định
    }

    public enum NetworkErrorType: Sendable{
        case noNetworkConnection
        case requestTimeout
        case unknown               // Lỗi kết nối mạng
    }

    public enum AlertActionNetworkError: Sendable {
        case retry
        case cancel
    }
}
