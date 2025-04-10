//
//  TxDeeplinkPath+GithubProfile.swift
//  TxDeeplink
//
//  Created by doandat on 10/4/25.
//
import Foundation

extension TxDeeplinkPath {
    public enum GithubProfile: String, CaseIterable, Sendable, Hashable {
        case list = "/githubProfile/list"
        case detail = "/githubProfile/detail"
        
        public static let allCases: [GithubProfile] = [
            .list, .detail
        ]
        
        public init?(url: URL) {
            let path = url.path
            if path == TxDeeplinkPath.GithubProfile.list.rawValue {
                self = .list
                return
            }
            if path == TxDeeplinkPath.GithubProfile.detail.rawValue {
                self = .detail
                return
            }
            return nil
        }
    }
    
}
