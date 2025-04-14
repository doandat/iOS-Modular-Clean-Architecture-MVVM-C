//
//  TxGithubUserManagerInterface.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Foundation

public protocol TxGithubUserManagerInterface {
    @MainActor
    func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUserDTO]
    @MainActor
    func getUserDetail(loginUsername: String) async throws -> TxGithubUserDTO
}
