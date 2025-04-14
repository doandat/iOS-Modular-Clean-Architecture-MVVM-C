//
//  TxDeeplinkPath+GithubProfile.swift
//  TxDeeplink
//
//  Created by doandat on 10/4/25.
//
import Foundation

/// Extension of TxDeeplinkPath for GitHub profile related deep links.
///
/// This extension defines the paths and functionality for deep links
/// related to GitHub profile features.
extension TxDeeplinkPath {
    /// Enum defining the available GitHub profile deep link paths.
    public enum GithubProfile: String, CaseIterable, Sendable, Hashable {
        /// Path for the GitHub user list screen.
        case list = "/githubProfile/list"
        
        /// Path for the GitHub user detail screen.
        case detail = "/githubProfile/detail"
        
        /// All available GitHub profile deep link paths.
        public static let allCases: [GithubProfile] = [
            .list, .detail
        ]
        
        /// Creates a GithubProfile enum from a URL.
        ///
        /// - Parameter url: The URL to parse
        /// - Returns: The corresponding GithubProfile enum, or nil if no match
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
