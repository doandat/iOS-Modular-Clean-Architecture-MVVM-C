import Foundation
import Combine
import Resolver

/// Protocol defining the use case for retrieving detailed information about a GitHub user.
///
/// This use case follows the Clean Architecture pattern and is responsible for:
/// - Coordinating the retrieval of user details
/// - Handling any necessary business logic
/// - Providing a clean interface for the presentation layer
public protocol TxGetUserDetailUseCase {
    /// Retrieves detailed information for a specific GitHub user.
    ///
    /// - Parameter loginUsername: The GitHub username of the user to fetch.
    /// - Returns: A `TxGithubUser` domain model with the user's details.
    /// - Throws: An error if the fetch operation fails.
    @MainActor
    func getUserDetail(loginUsername: String) async throws -> TxGithubUser
}

/// Implementation of the `TxGetUserDetailUseCase` protocol.
///
/// This class uses dependency injection to access the user repository
/// and delegates the actual data fetching to it.
public class TxGetUserDetailUseCaseImpl: TxGetUserDetailUseCase {
    @Injected private var repository: TxUserRepository

    /// Creates a new use case instance.
    public init() {}

    /// Retrieves detailed information for a specific GitHub user.
    ///
    /// - Parameter loginUsername: The GitHub username of the user to fetch.
    /// - Returns: A `TxGithubUser` domain model with the user's details.
    /// - Throws: An error if the fetch operation fails.
    @MainActor public func getUserDetail(loginUsername: String) async throws -> TxGithubUser {
        return try await repository.getUserDetail(loginUsername: loginUsername)
    }
}
