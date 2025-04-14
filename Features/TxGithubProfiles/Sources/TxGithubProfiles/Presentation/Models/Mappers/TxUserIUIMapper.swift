//
//  TxUserItemUIMapper.swift
//  TxGithubProfiles
//
//  Created by doandat on 11/4/25.
//

import Foundation

extension TxGithubUser {
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
