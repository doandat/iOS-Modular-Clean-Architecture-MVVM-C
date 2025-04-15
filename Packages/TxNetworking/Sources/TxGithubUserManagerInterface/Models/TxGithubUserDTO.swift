//
//  TxGithubUserDTO.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//
import Foundation

/// Data Transfer Object representing a GitHub user.
///
/// This struct contains all the fields returned by the GitHub API for a user,
/// including their profile information, social links, and statistics.
public struct TxGithubUserDTO: Codable {
    /// The username of the GitHub user
    public let login: String?
    
    /// The unique identifier of the GitHub user
    public let id: Int?
    
    /// The node ID of the GitHub user
    public let node_id: String?
    
    /// URL to the user's avatar image
    public let avatar_url: String?
    
    /// The user's Gravatar ID
    public let gravatar_id: String?
    
    /// API URL for the user
    public let url: String?
    
    /// URL to the user's GitHub profile page
    public let html_url: String?
    
    /// API URL for the user's followers
    public let followers_url: String?
    
    /// API URL for the users this user is following
    public let following_url: String?
    
    /// API URL for the user's gists
    public let gists_url: String?
    
    /// API URL for the repositories starred by the user
    public let starred_url: String?
    
    /// API URL for the user's subscriptions
    public let subscriptions_url: String?
    
    /// API URL for the user's organizations
    public let organizations_url: String?
    
    /// API URL for the user's repositories
    public let repos_url: String?
    
    /// API URL for the user's events
    public let events_url: String?
    
    /// API URL for events received by the user
    public let received_events_url: String?
    
    /// Whether the user is a site administrator
    public let site_admin: Bool?
    
    /// The user's full name
    public let name: String?
    
    /// The user's company
    public let company: String?
    
    /// The user's blog URL
    public let blog: String?
    
    /// The user's location
    public let location: String?
    
    /// The user's email address
    public let email: String?
    
    /// The user's biography
    public let bio: String?
    
    /// The user's Twitter username
    public let twitter_username: String?
    
    /// Number of public repositories owned by the user
    public let public_repos: Int?
    
    /// Number of public gists owned by the user
    public let public_gists: Int?
    
    /// Number of followers
    public let followers: Int?
    
    /// Number of users being followed
    public let following: Int?
    
    /// Creates a new GitHub user DTO instance.
    ///
    /// - Parameters:
    ///   - login: The username
    ///   - id: The unique identifier
    ///   - node_id: The node ID
    ///   - avatar_url: URL to the avatar
    ///   - gravatar_id: The Gravatar ID
    ///   - url: API URL
    ///   - html_url: Profile page URL
    ///   - followers_url: Followers API URL
    ///   - following_url: Following API URL
    ///   - gists_url: Gists API URL
    ///   - starred_url: Starred repositories API URL
    ///   - subscriptions_url: Subscriptions API URL
    ///   - organizations_url: Organizations API URL
    ///   - repos_url: Repositories API URL
    ///   - events_url: Events API URL
    ///   - received_events_url: Received events API URL
    ///   - site_admin: Site admin status
    ///   - name: Full name
    ///   - company: Company name
    ///   - blog: Blog URL
    ///   - location: Location
    ///   - email: Email address
    ///   - bio: Biography
    ///   - twitter_username: Twitter username
    ///   - public_repos: Number of public repositories
    ///   - public_gists: Number of public gists
    ///   - followers: Number of followers
    ///   - following: Number of users being followed
    public init(
        login: String?,
        id: Int?,
        node_id: String? = nil,
        avatar_url: String?,
        gravatar_id: String? = nil,
        url: String? = nil,
        html_url: String? = nil,
        followers_url: String? = nil,
        following_url: String? = nil,
        gists_url: String? = nil,
        starred_url: String? = nil,
        subscriptions_url: String? = nil,
        organizations_url: String? = nil,
        repos_url: String? = nil,
        events_url: String? = nil,
        received_events_url: String? = nil,
        site_admin: Bool? = nil,
        name: String? = nil,
        company: String? = nil,
        blog: String? = nil,
        location: String? = nil,
        email: String? = nil,
        bio: String? = nil,
        twitter_username: String? = nil,
        public_repos: Int? = nil,
        public_gists: Int? = nil,
        followers: Int? = nil,
        following: Int? = nil
    ) {
        self.login = login
        self.id = id
        self.node_id = node_id
        self.avatar_url = avatar_url
        self.gravatar_id = gravatar_id
        self.url = url
        self.html_url = html_url
        self.followers_url = followers_url
        self.following_url = following_url
        self.gists_url = gists_url
        self.starred_url = starred_url
        self.subscriptions_url = subscriptions_url
        self.organizations_url = organizations_url
        self.repos_url = repos_url
        self.events_url = events_url
        self.received_events_url = received_events_url
        self.site_admin = site_admin
        self.name = name
        self.company = company
        self.blog = blog
        self.location = location
        self.email = email
        self.bio = bio
        self.twitter_username = twitter_username
        self.public_repos = public_repos
        self.public_gists = public_gists
        self.followers = followers
        self.following = following
    }
}
