//
//  TxUserDetailUIModel.swift
//  TxGithubProfiles
//
//  Created by doandat on 11/4/25.
//
import Foundation

/// Model representing a GitHub user's detailed information for display in the user detail screen.
///
/// This model extends the basic user information with additional details
/// specific to the user detail view, such as follower counts and blog information.
struct TxUserDetailUIModel {
    /// The basic user information, shared with the list view.
    let baseInfo: TxUserItemUIModel

    /// The formatted string representation of the user's follower count.
    /// This may include a "+" suffix if the count exceeds the maximum display value.
    let followers: String

    /// The formatted string representation of the user's following count.
    /// This may include a "+" suffix if the count exceeds the maximum display value.
    let following: String

    /// The URL of the user's blog or website.
    let blogUrl: String
}
