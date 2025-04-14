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

/// Service implementation for GitHub user management.
///
/// This service provides concrete implementation of the GitHub user management interface,
/// using Moya for network requests and handling the GitHub API responses.
public struct TxGithubUserManagerService: TxGithubUserManagerInterface {
    /// The target type for Moya requests
    public typealias Target = TxGithubUserTargetBuilder

    /// The Moya provider used for making network requests
    public var moyaProvider: MoyaProvider<Target>
    
    /// The base URL for the GitHub API
    private let baseURL: URL

    /// Creates a new GitHub user manager service instance.
    ///
    /// - Parameters:
    ///   - baseURL: The base URL for the GitHub API
    ///   - moyaProvider: Optional custom Moya provider (defaults to a new instance)
    public init(
        baseURL: URL,
        moyaProvider: MoyaProvider<Target>? = nil
    ) {
        self.moyaProvider = moyaProvider ?? MoyaProvider<Target>(plugins: [])
        self.baseURL = baseURL
    }

    /// Retrieves a list of GitHub users with pagination support.
    ///
    /// - Parameters:
    ///   - since: The ID of the last user to start from
    ///   - pageSize: The number of users to retrieve per page
    /// - Returns: An array of GitHub user DTOs
    /// - Throws: An error if the request fails
    public func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUserDTO] {
        let target = Target(
            operation: .getUsers(since: since, pageSize: pageSize),
            baseURL: baseURL
        )
        return try await moyaProvider.performRequest(target: target)
    }

    /// Retrieves detailed information about a specific GitHub user.
    ///
    /// - Parameter loginUsername: The username of the GitHub user
    /// - Returns: A GitHub user DTO containing the user's details
    /// - Throws: An error if the request fails
    public func getUserDetail(loginUsername: String) async throws -> TxGithubUserDTO {
        let target = Target(
            operation: .getUserDetail(loginUsername: loginUsername),
            baseURL: baseURL
        )
        return try await moyaProvider.performRequest(target: target)
    }
}
