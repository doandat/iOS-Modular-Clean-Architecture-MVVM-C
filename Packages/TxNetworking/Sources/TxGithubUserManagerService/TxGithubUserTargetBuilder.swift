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

public struct TxGithubUserTargetBuilder: TargetType, AccessTokenAuthorizable {
    let operation: OperationType

    public var baseURL: URL

    public var path: String {
        switch operation {
        case .getUsers:
            return "/users"
        case let .getUserDetail(loginUsername):
            return "/users/\(loginUsername)"
        }
    }

    public var method: Moya.Method {
        switch operation {
        case .getUsers, .getUserDetail:
            return .get
        }
    }

    /// The type of HTTP task to be performed.
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

    /// The type of validation to perform on the request. Default is `.none`.
    public var validationType: ValidationType {
        .none
    }

    /// The headers to be used in the request.
    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    public var authorizationType: AuthorizationType? {
        return .bearer
    }
}

extension TxGithubUserTargetBuilder {
    enum OperationType {
        case getUsers(since: Int, pageSize: Int)
        case getUserDetail(loginUsername: String)
    }
}
