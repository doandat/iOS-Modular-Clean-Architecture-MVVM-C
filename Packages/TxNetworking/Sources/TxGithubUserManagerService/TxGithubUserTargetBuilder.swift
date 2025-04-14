//
//  TxGithubUserTargetBuilder.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Foundation
import Moya
import os
import TxLogger
import TxGithubUserManagerInterface

/// Builder for GitHub user API targets.
///
/// This struct implements Moya's TargetType protocol to define the structure
/// of API requests for GitHub user operations.
public struct TxGithubUserTargetBuilder: TargetType, AccessTokenAuthorizable {
    /// The operation to perform
    let operation: OperationType

    /// The base URL for the API
    public var baseURL: URL

    /// The path component of the URL for the current operation.
    public var path: String {
        switch operation {
        case .getUsers:
            return "/users"
        case let .getUserDetail(loginUsername):
            return "/users/\(loginUsername)"
        }
    }

    /// The HTTP method to use for the request.
    public var method: Moya.Method {
        switch operation {
        case .getUsers, .getUserDetail:
            return .get
        }
    }

    /// The type of HTTP task to be performed.
    ///
    /// This defines how the request parameters should be encoded and sent.
    public var task: Task {
        switch operation {
        case let .getUsers(since, pageSize):
            return .requestParameters(
                parameters: [
                    "per_page": pageSize,
                    "since": since
                ],
                encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets)
            )
        case .getUserDetail:
            return .requestPlain
        }
    }

    /// The type of validation to perform on the request.
    public var validationType: ValidationType {
        .none
    }

    /// The headers to be used in the request.
    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    /// The type of authorization to use for the request.
    public var authorizationType: AuthorizationType? {
        return .bearer
    }
}

extension TxGithubUserTargetBuilder {
    /// Enumeration defining the types of operations that can be performed.
    enum OperationType {
        /// Retrieves a list of users with pagination
        case getUsers(since: Int, pageSize: Int)
        
        /// Retrieves details for a specific user
        case getUserDetail(loginUsername: String)
    }
}
