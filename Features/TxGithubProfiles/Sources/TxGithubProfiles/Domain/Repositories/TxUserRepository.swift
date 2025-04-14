import Foundation
import Combine

/// Protocol defining the interface for GitHub user data operations.
///
/// This protocol outlines the required functionality for any repository implementation
/// that handles GitHub user data. It follows the Repository pattern to abstract
/// the data source implementation details from the domain layer.
public protocol TxUserRepository {
    /// Fetches a list of GitHub users with pagination support.
    ///
    /// - Parameters:
    ///   - since: The ID of the last user from the previous page.
    ///   - pageSize: The number of users to fetch per page.
    /// - Returns: An array of `TxGithubUser` domain models.
    /// - Throws: An error if the fetch operation fails.
    @MainActor
    func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUser]

    /// Fetches detailed information for a specific GitHub user.
    ///
    /// - Parameter loginUsername: The GitHub username of the user to fetch.
    /// - Returns: A `TxGithubUser` domain model with the user's details.
    /// - Throws: An error if the fetch operation fails.
    @MainActor
    func getUserDetail(loginUsername: String) async throws -> TxGithubUser
}
