//
//  TxGithubUserParser.swift
//  TxGithubProfiles
//
//  Created by doandat on 12/4/25.
//

import TxGithubUserManagerInterface

/// Extension providing parsing functionality for GitHub user data.
///
/// This extension adds methods to convert between different representations of GitHub user data,
/// specifically from DTO (Data Transfer Object) to domain model.
extension TxGithubUserDTO {
    /// Converts a GitHub user DTO to a domain model.
    ///
    /// This method handles the transformation of API response data into the application's domain model,
    /// providing default values for optional fields.
    ///
    /// - Returns: A `TxGithubUser` domain model with the parsed data.
    func toDomainUser() -> TxGithubUser {
        return TxGithubUser(
            id: id ?? 0,
            name: name ?? "",
            username: login ?? "",
            avatarUrl: avatar_url ?? "",
            landingPageUrl: html_url ?? "",
            location: location ?? "",
            followers: followers ?? 0,
            following: following ?? 0,
            blogUrl: blog ?? ""
        )
    }
}
