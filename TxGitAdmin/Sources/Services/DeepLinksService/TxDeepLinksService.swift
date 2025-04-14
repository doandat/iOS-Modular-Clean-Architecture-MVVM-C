//
//  TxDeepLinksService.swift
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

public protocol TxDeepLinksServiceProtocol {
    @MainActor @discardableResult
    func handleURL(_ url: URL) -> Bool
    func canOpenURL(_ url: URL) -> Bool
    var rootViewController: UINavigationController? { get set }
}


final class TxDeepLinksService: TxDeepLinksServiceProtocol {
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

    @MainActor static func getRootView() -> any View {
        return TxGithubProfileCoordinator.getRootView()
    }

}
