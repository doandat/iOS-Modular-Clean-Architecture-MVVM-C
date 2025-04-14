//
//  TxUserItemUIModel.swift
//  TxGithubProfiles
//
//  Created by doandat on 11/4/25.
//
import Foundation

/// Model representing a GitHub user's basic information for display in UI lists.
///
/// This model contains the essential information needed to display a user
/// in a list view, such as the user list screen.
struct TxUserItemUIModel: Identifiable, Equatable, Sendable {
    /// The unique identifier of the user.
    let id: Int

    /// The display name of the user.
    let name: String

    /// The GitHub username of the user.
    let loginUsername: String

    /// The URL of the user's avatar image.
    let avatarUrl: String

    /// The URL of the user's GitHub profile page.
    let landingPageUrl: String

    /// The user's location.
    let location: String
}
