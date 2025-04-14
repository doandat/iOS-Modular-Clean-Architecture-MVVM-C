import Foundation
import Combine
import TxGithubUserManagerInterface

/// Implementation of the user repository interface for GitHub profiles.
///
/// This class handles the data operations for GitHub users, including:
/// - Fetching lists of users
/// - Retrieving detailed user information
/// - Converting API responses to domain models
public class TxUserRepositoryImpl: TxUserRepository {
    private let remoteDataSource: TxGithubUserManagerInterface

    /// Creates a new repository instance with the specified data source.
    ///
    /// - Parameter remoteDataSource: The data source for fetching GitHub user data.
    public init(remoteDataSource: TxGithubUserManagerInterface) {
        self.remoteDataSource = remoteDataSource
    }

    /// Fetches a list of GitHub users with pagination support.
    ///
    /// - Parameters:
    ///   - since: The ID of the last user from the previous page.
    ///   - pageSize: The number of users to fetch per page.
    /// - Returns: An array of `TxGithubUser` domain models.
    /// - Throws: An error if the fetch operation fails.
    public func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUser] {
        let response = try await remoteDataSource.getUsers(since: since, pageSize: pageSize)
        return response.map { $0.toDomainUser() }
    }

    /// Fetches detailed information for a specific GitHub user.
    ///
    /// - Parameter loginUsername: The GitHub username of the user to fetch.
    /// - Returns: A `TxGithubUser` domain model with the user's details.
    /// - Throws: An error if the fetch operation fails.
    public func getUserDetail(loginUsername: String) async throws -> TxGithubUser {
        let response = try await remoteDataSource.getUserDetail(loginUsername: loginUsername)
        return response.toDomainUser()
    }
}

extension TxUserRepositoryImpl {
    /// Mock data for testing and development purposes.
    ///
    /// This property provides a set of sample GitHub users that can be used
    /// for testing the UI and functionality without making actual API calls.
    private var mockUsers: [TxGithubUser] {
        return [
            TxGithubUser(
                id: 1,
                name: "David",
                username: "David Patel",
                avatarUrl: "https://avatars.githubusercontent.com1/u/101?v=4",
                landingPageUrl: "https://www.linkedin.com/",
                location: "Vietnam",
                followers: 100,
                following: 10,
                blogUrl: "https://blog.abc"
            ),
            TxGithubUser(
                id: 2,
                name: "Lisa",
                username: "Lisa",
                avatarUrl: "https://avatars.githubusercontent.com/u/102?v=4",
                landingPageUrl: "https://www.linkedin.com/",
                location: "Vietnam",
                followers: 100,
                following: 10,
                blogUrl: "https://blog.abc"
            ),
            TxGithubUser(
                id: 3,
                name: "Alex",
                username: "Alex",
                avatarUrl: "https://avatars.githubusercontent.com/u/103?v=4",
                landingPageUrl: "https://www.linkedin.com/",
                location: "Vietnam",
                followers: 100,
                following: 10,
                blogUrl: "https://blog.abc"
            ),
            TxGithubUser(
                id: 4,
                name: "Piter",
                username: "Piter",
                avatarUrl: "https://avatars.githubusercontent.com/u/104?v=4",
                landingPageUrl: "https://www.linkedin.com/",
                location: "Vietnam",
                followers: 100,
                following: 10,
                blogUrl: "https://blog.abc"
            ),
            TxGithubUser(
                id: 5,
                name: "Eddi",
                username: "Eddi",
                avatarUrl: "https://avatars.githubusercontent.com/u/105?v=4",
                landingPageUrl: "https://www.linkedin.com/",
                location: "Vietnam",
                followers: 100,
                following: 10,
                blogUrl: "https://blog.abc"
            ),
            TxGithubUser(
                id: 6,
                name: "Ga",
                username: "Ga",
                avatarUrl: "https://avatars.githubusercontent.com/u/106?v=4",
                landingPageUrl: "https://www.linkedin.com/",
                location: "Vietnam",
                followers: 100,
                following: 10,
                blogUrl: "https://blog.abc"
            ),
            TxGithubUser(
                id: 12,
                name: "Sandy",
                username: "Sandy",
                avatarUrl: "https://avatars.githubusercontent.com/u/107?v=4",
                landingPageUrl: "https://www.linkedin.com/",
                location: "Vietnam",
                followers: 101,
                following: 20,
                blogUrl: "https://blog.abc"
            )
        ]
    }
}
