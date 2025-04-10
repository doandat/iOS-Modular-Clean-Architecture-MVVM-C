//
//  TxGithubProfileDeeplinkHandler.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import Foundation
import TxDeeplink
import Resolver

public final class TxGithubProfileDeeplinkHandler: TxDeeplinkHandlerProtocol {
    public init() {}

    public func canOpenURL(_ url: URL) -> Bool {
        let path = url.absoluteString

        return TxDeeplinkPath.GithubProfile.allCases.contains {
            path.contains($0.rawValue)
        }
    }

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
            coordinator.routeToAccountlist()
        case .detail:
            coordinator.routeToAccountDetail()
        }
    }
}
