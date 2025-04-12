import Foundation
import Combine

public class TxUserRepositoryImpl: TxUserRepository {
    private let mockUsers: [TxGithubUser] = [
        TxGithubUser(
            id: "1",
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
            id: "2",
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
            id: "3",
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
            id: "4",
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
            id: "5",
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
            id: "6",
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
            id: "12",
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

    public init() {}

    public func getUsers(page: Int, pageSize: Int) async throws -> [TxGithubUser] {
        return mockUsers
    }

    public func getUserDetail(userId: String) async throws -> TxGithubUser {
        guard let user = mockUsers.first(where: { $0.id == userId }) else {
            throw NSError(domain: "TxUserRepository", code: 404, userInfo: nil)
        }
        return user
    }
}
