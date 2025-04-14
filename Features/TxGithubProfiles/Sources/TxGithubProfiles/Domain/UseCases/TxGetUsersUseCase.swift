import Foundation
import Combine
import Resolver

/// Protocol defining the use case for retrieving lists of GitHub users.
///
/// This use case follows the Clean Architecture pattern and is responsible for:
/// - Coordinating the retrieval of user lists
/// - Handling pagination logic
/// - Providing a clean interface for the presentation layer
public protocol TxGetUsersUseCase {
    /// Retrieves a list of GitHub users with pagination support.
    ///
    /// - Parameters:
    ///   - since: The ID of the last user from the previous page.
    ///   - pageSize: The number of users to fetch per page.
    /// - Returns: An array of `TxGithubUser` domain models.
    /// - Throws: An error if the fetch operation fails.
    @MainActor
    func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUser]
}

/// Implementation of the `TxGetUsersUseCase` protocol.
///
/// This class uses dependency injection to access the user repository
/// and delegates the actual data fetching to it.
public class TxGetUsersUseCaseImpl: TxGetUsersUseCase {
    @Injected private var repository: TxUserRepository

    /// Creates a new use case instance.
    public init() {}

    /// Retrieves a list of GitHub users with pagination support.
    ///
    /// - Parameters:
    ///   - since: The ID of the last user from the previous page.
    ///   - pageSize: The number of users to fetch per page.
    /// - Returns: An array of `TxGithubUser` domain models.
    /// - Throws: An error if the fetch operation fails.
    public func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUser] {
        return try await repository.getUsers(since: since, pageSize: pageSize)
    }
}
