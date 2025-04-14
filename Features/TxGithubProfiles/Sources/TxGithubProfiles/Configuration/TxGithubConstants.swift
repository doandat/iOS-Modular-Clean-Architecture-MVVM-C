//
//  TxGithubConstants.swift
//  TxGithubProfiles
//
//  Created by doandat on 12/4/25.
//

import Foundation

/// Constants used throughout the GitHub Profiles module.
///
/// This enum contains configuration values and limits used in the module.
public enum TxGithubConstants {
    /// The number of items to fetch per page when loading user data.
    public static let pageSize: Int = 20

    /// The maximum number of followers to display for a user.
    public static let maxFollowerNumber: Int = 100

    /// The maximum number of following users to display for a user.
    public static let maxFollowingNumber: Int = 10
}
