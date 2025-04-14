//
//  TxUserItemUIMapper.swift
//  TxGithubProfiles
//
//  Created by doandat on 11/4/25.
//

import Foundation

/// Extension providing mapping functionality to convert domain models to UI models.
///
/// This extension adds methods to transform `TxGithubUser` domain models
/// into UI-specific models for different display contexts.
extension TxGithubUser {
    /// Converts a GitHub user domain model to a list item UI model.
    ///
    /// This method creates a simplified version of the user data
    /// suitable for display in a list view.
    ///
    /// - Returns: A `TxUserItemUIModel` containing the user's basic information.
    func toMapListUI() -> TxUserItemUIModel {
        return TxUserItemUIModel(
            id: id,
            name: username,
            loginUsername: username,
            avatarUrl: avatarUrl,
            landingPageUrl: landingPageUrl,
            location: location
        )
    }

    /// Converts a GitHub user domain model to a detail UI model.
    ///
    /// This method creates a detailed version of the user data
    /// suitable for display in a detail view, including:
    /// - Basic user information
    /// - Formatted follower and following counts
    /// - Blog URL
    ///
    /// - Returns: A `TxUserDetailUIModel` containing the user's complete information.
    func toMapDetailUI() -> TxUserDetailUIModel {
        let maxFollower = TxGithubConstants.maxFollowerNumber
        let maxFollowing = TxGithubConstants.maxFollowingNumber
        let followersStr = followers > maxFollower ? "\(maxFollower)+" : "\(followers)"
        let followingStr = following > maxFollowing ? "\(maxFollowing)+" : "\(following)"
        return TxUserDetailUIModel(
            baseInfo: toMapListUI(),
            followers: followersStr,
            following: followingStr,
            blogUrl: blogUrl
        )
    }
}
