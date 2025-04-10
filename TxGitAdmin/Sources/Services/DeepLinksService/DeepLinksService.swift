//
//  DeepLinksService.swift
//  TxGitAdmin
//
//  Created by doandat on 10/4/25.
//

import Foundation
import UIKit
import SwiftUI
import Resolver
import TxDeeplink
import TxGithubProfiles

final class DeepLinksService: TxDeeplinkCoordinatorProtocol {
    static let shared = DeepLinksService()
    
    var pendingDeeplink: URL?
    
    var rootViewController: UINavigationController? {
        didSet {
            guard let rootViewController else { return }
            Resolver.register { TxGithubProfileCoordinator(rootViewController: rootViewController) as TxGithubProfileNavigation }.scope(ResolverScope.application)
        }
    }
    
    private lazy var handlers: [TxDeeplinkHandlerProtocol] = [
        TxGithubProfileDeeplinkHandler()
    ]
    
    private var deepLinkCoordinator: TxDeeplinkCoordinator {
        let v = TxDeeplinkCoordinator(handlers: handlers)
        return v
    }

    @discardableResult
    func handleURL(_ url: URL) -> Bool {
        return deepLinkCoordinator.handleURL(url)
    }

    func canOpenURL(_ url: URL) -> Bool {
        return deepLinkCoordinator.canOpenURL(url)
    }

    @MainActor func getRootView() -> any View {
        return TxGithubProfileCoordinator.getRootView()
    }

}
