//
//  TxGithubUserManagerService.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Foundation
import SwiftyJSON
import Moya
import TxMoyaExt
import TxGithubUserManagerInterface
import TxNetworkModels


public struct TxGithubUserManagerService: TxGithubUserManagerInterface {
    public typealias Target = TxGithubUserTargetBuilder

    public var moyaProvider: MoyaProvider<Target>
    private let baseURL: URL

    public init(
        baseURL: URL,
        moyaProvider: MoyaProvider<Target>? = nil
    ) {
        self.moyaProvider = moyaProvider ?? MoyaProvider<Target>(plugins: [])
        self.baseURL = baseURL
    }

    public func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUserDTO] {
        let target = Target(
            operation: .getUsers(since: since, pageSize: pageSize),
            baseURL: baseURL
        )
        return try await moyaProvider.performRequest(target: target)
    }

    public func getUserDetail(loginUsername: String) async throws -> TxGithubUserDTO {
        let target = Target(
            operation: .getUserDetail(loginUsername: loginUsername),
            baseURL: baseURL
        )
        return try await moyaProvider.performRequest(target: target)
    }
}
