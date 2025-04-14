//
//  TxGithubUserParser.swift
//  TxGithubProfiles
//
//  Created by doandat on 12/4/25.
//

import TxGithubUserManagerInterface

extension TxGithubUserDTO {
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
