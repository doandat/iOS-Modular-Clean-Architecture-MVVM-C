//
//  TxGithubProfileDeeplinkHandler.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import Foundation
import Resolver
import TxDeeplink
import TxFoundation

/// Handler for deep linking in the GitHub Profiles module.
///
/// This class implements the `TxDeeplinkHandlerProtocol` to handle deep links related to GitHub profiles.
/// It supports navigation to both the user list and user detail screens through deep links.
public final class TxGithubProfileDeeplinkHandler: TxDeeplinkHandlerProtocol {
    /// Creates a new deep link handler instance.
    public init() {}

    /// Determines whether the handler can process the given URL.
    ///
    /// - Parameter url: The URL to check.
    /// - Returns: `true` if the URL matches any of the supported GitHub profile deep link paths.
    public func canOpenURL(_ url: URL) -> Bool {
        let path = url.absoluteString

        return TxDeeplinkPath.GithubProfile.allCases.contains {
            path.contains($0.rawValue)
        }
    }

    /// Processes the deep link URL and navigates to the appropriate screen.
    ///
    /// This method:
    /// - Validates the URL against supported paths
    /// - Extracts necessary parameters
    /// - Uses the coordinator to navigate to the appropriate screen
    ///
    /// - Parameter url: The deep link URL to process.
    @MainActor
    public func openURL(_ url: URL) {
        guard
            let coordinator = Resolver.optional(TxGithubProfileNavigation.self),
            let validPath = TxDeeplinkPath.GithubProfile(url: url)
        else {
            return
        }
        switch validPath {
        case .list:
            coordinator.routeToUserlist()
        case .detail:
            let params = url.parseQueryParameters()
            guard let loginUsername = params["loginUsername"] else {
                return
            }
            coordinator.routeToUserDetail(loginUsername: loginUsername)
        }
    }
}
