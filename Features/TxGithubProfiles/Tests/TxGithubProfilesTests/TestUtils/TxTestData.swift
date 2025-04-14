import Foundation
@testable import TxGithubProfiles

enum TxTestData {
    static let testUsers: [TxGithubUser] = [
        TxGithubUser(
            id: 1,
            name: "Test User 1",
            username: "testuser1",
            avatarUrl: "https://example.com/avatar1.png",
            landingPageUrl: "https://example.com/user1",
            location: "Test Location 1",
            followers: 100,
            following: 50,
            blogUrl: "https://example.com/blog1"
        ),
        TxGithubUser(
            id: 2,
            name: "Test User 2",
            username: "testuser2",
            avatarUrl: "https://example.com/avatar2.png",
            landingPageUrl: "https://example.com/user2",
            location: "Test Location 2",
            followers: 200,
            following: 100,
            blogUrl: "https://example.com/blog2"
        )
    ]
    
    static let testUserDetail: TxGithubUser = TxGithubUser(
        id: 3,
        name: "Test User 3",
        username: "testuser3",
        avatarUrl: "https://example.com/avatar3.png",
        landingPageUrl: "https://example.com/user3",
        location: "Test Location 3",
        followers: 300,
        following: 150,
        blogUrl: "https://example.com/blog3"
    )
} 
