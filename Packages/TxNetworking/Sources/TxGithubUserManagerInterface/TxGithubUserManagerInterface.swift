//
//  TxGithubUserManagerInterface.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Foundation

/// Protocol defining the interface for GitHub user management functionality.
///
/// This protocol provides methods for:
/// - Retrieving a list of GitHub users
/// - Getting detailed information about a specific GitHub user
public protocol TxGithubUserManagerInterface {
    /// Retrieves a list of GitHub users with pagination support.
    ///
    /// - Parameters:
    ///   - since: The ID of the last user to start from
    ///   - pageSize: The number of users to retrieve per page
    /// - Returns: An array of GitHub user DTOs
    /// - Throws: An error if the request fails
    @MainActor
    func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUserDTO]
    
    /// Retrieves detailed information about a specific GitHub user.
    ///
    /// - Parameter loginUsername: The username of the GitHub user
    /// - Returns: A GitHub user DTO containing the user's details
    /// - Throws: An error if the request fails
    @MainActor
    func getUserDetail(loginUsername: String) async throws -> TxGithubUserDTO
}
