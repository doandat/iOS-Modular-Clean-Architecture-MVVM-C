//
//  TxGithubUserDTO.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//
import Foundation

public struct TxGithubUserDTO: Decodable {
    public let login: String?
    public let id: Int?
    public let node_id: String?
    public let avatar_url: String?
    public let gravatar_id: String?
    public let url: String?
    public let html_url: String?
    public let followers_url: String?
    public let following_url: String?
    public let gists_url: String?
    public let starred_url: String?
    public let subscriptions_url: String?
    public let organizations_url: String?
    public let repos_url: String?
    public let events_url: String?
    public let received_events_url: String?
    public let site_admin: Bool?
    public let name: String?
    public let company: String?
    public let blog: String?
    public let location: String?
    public let email: String?
    public let bio: String?
    public let twitter_username: String?
    public let public_repos: Int?
    public let public_gists: Int?
    public let followers: Int?
    public let following: Int?
    
    public init(
        login: String?,
        id: Int?,
        node_id: String?,
        avatar_url: String?,
        gravatar_id: String?,
        url: String?,
        html_url: String?,
        followers_url: String?,
        following_url: String?,
        gists_url: String?,
        starred_url: String?,
        subscriptions_url: String?,
        organizations_url: String?,
        repos_url: String?,
        events_url: String?,
        received_events_url: String?,
        site_admin: Bool?,
        name: String?,
        company: String?,
        blog: String?,
        location: String?,
        email: String?,
        bio: String?,
        twitter_username: String?,
        public_repos: Int?,
        public_gists: Int?,
        followers: Int?,
        following: Int?
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
