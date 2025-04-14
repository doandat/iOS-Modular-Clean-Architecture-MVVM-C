//
//  TxUserItemUIModel.swift
//  TxGithubProfiles
//
//  Created by doandat on 11/4/25.
//
import Foundation

struct TxUserItemUIModel: Identifiable, Equatable, Sendable {
    let id: Int
    let name: String
    let loginUsername: String
    let avatarUrl: String
    let landingPageUrl: String
    let location: String
}
