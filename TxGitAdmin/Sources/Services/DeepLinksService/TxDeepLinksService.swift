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

/// Protocol defining the interface for deep linking services.
///
/// This protocol specifies the requirements for handling deep links in the application:
/// - Handling URLs
/// - Checking URL compatibility
/// - Managing the root view controller
public protocol TxDeepLinksServiceProtocol {
    /// Handles a deep link URL.
    ///
    /// - Parameter url: The URL to handle
    /// - Returns: True if the URL was handled successfully
    @MainActor @discardableResult
    func handleURL(_ url: URL) -> Bool
    
    /// Checks if a URL can be opened by the application.
    ///
    /// - Parameter url: The URL to check
    /// - Returns: True if the URL can be handled
    func canOpenURL(_ url: URL) -> Bool
    
    /// The root navigation controller for the application
    var rootViewController: UINavigationController? { get set }
}

/// Service responsible for handling deep links in the application.
///
/// This service:
/// - Manages deep link handlers
/// - Coordinates deep link processing
/// - Maintains navigation state
final class TxDeepLinksService: TxDeepLinksServiceProtocol {
    /// The pending deep link URL waiting to be processed
    var pendingDeeplink: URL?
    
    /// The root navigation controller for the application.
    ///
    /// When set, it:
    /// - Updates the GitHub profile coordinator
    /// - Registers the coordinator with the dependency injection system
    var rootViewController: UINavigationController? {
        didSet {
            guard let rootViewController else { return }
            Resolver.register { TxGithubProfileCoordinator(rootViewController: rootViewController) as TxGithubProfileNavigation }.scope(ResolverScope.application)
        }
    }
    
    /// Array of registered deep link handlers
    private lazy var handlers: [TxDeeplinkHandlerProtocol] = [
        TxGithubProfileDeeplinkHandler()
    ]
    
    /// The coordinator responsible for processing deep links
    private var deepLinkCoordinator: TxDeeplinkCoordinator {
        let v = TxDeeplinkCoordinator(handlers: handlers)
        return v
    }

    /// Handles a deep link URL by delegating to the coordinator.
    ///
    /// - Parameter url: The URL to handle
    /// - Returns: True if the URL was handled successfully
    @discardableResult
    func handleURL(_ url: URL) -> Bool {
        return deepLinkCoordinator.handleURL(url)
    }

    /// Checks if a URL can be opened by delegating to the coordinator.
    ///
    /// - Parameter url: The URL to check
    /// - Returns: True if the URL can be handled
    func canOpenURL(_ url: URL) -> Bool {
        return deepLinkCoordinator.canOpenURL(url)
    }

    /// Gets the root view for the application.
    ///
    /// - Returns: The root view configured for deep linking
    @MainActor static func getRootView() -> any View {
        return TxGithubProfileCoordinator.getRootView()
    }
}
