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
}
