import Foundation

/// Represents a GitHub user profile with basic and detailed information.
/// This model is used throughout the application to represent user data
/// fetched from the GitHub API or other data sources.
///
/// The model includes both basic information (used in list views) and
/// detailed information (used in detail views).
///
/// - Note: All properties are immutable to ensure thread safety and
///         prevent unintended modifications.
public struct TxGithubUser: Identifiable, Sendable {
    /// Unique identifier for the user
    public let id: Int

    /// User's display name
    public let name: String

    /// User's full name (optional)
    public let username: String

    /// URL to the user's avatar image
    public let avatarUrl: String

    /// URL to the user's LinkedIn profile
    public let landingPageUrl: String

    /// User's location (optional)
    public let location: String

    /// Number of followers
    public let followers: Int

    /// Number of users being followed
    public let following: Int

    /// URL to the user's blog or website (optional)
    public let blogUrl: String

    /// Creates a new GitHub user instance.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the user
    ///   - name: User's display name
    ///   - username: User's full name (optional)
    ///   - avatarUrl: URL to the user's avatar image
    ///   - landingPageUrl: URL to the user's LinkedIn profile
    ///   - location: User's location (optional)
    ///   - followers: Number of followers
    ///   - following: Number of users being followed
    ///   - blogUrl: URL to the user's blog or website (optional)
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
