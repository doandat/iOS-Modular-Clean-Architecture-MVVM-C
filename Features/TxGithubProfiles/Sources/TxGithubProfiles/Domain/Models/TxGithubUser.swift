import Foundation

public struct TxGithubUser: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let username: String
    public let avatarUrl: String
    public let landingPageUrl: String
    public let location: String
    public let followers: Int
    public let following: Int
    public let blogUrl: String

    public init(
        id: Int,
        name: String,
        username: String,
        avatarUrl: String,
        landingPageUrl: String,
        location: String,
        followers: Int,
        following: Int,
        blogUrl: String
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.avatarUrl = avatarUrl
        self.landingPageUrl = landingPageUrl
        self.location = location
        self.followers = followers
        self.following = following
        self.blogUrl = blogUrl
    }
}
