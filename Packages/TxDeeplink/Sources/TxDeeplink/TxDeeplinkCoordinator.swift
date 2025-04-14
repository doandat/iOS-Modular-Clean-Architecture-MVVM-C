//
//  TxDeeplinkCoordinator.swift
//  TxDeeplink
//
//  Created by doandat on 10/4/25.
//

import Foundation

/// Protocol defining the interface for coordinating deep link handling.
///
/// This protocol is implemented by coordinators that manage multiple deep link handlers
/// and route URLs to the appropriate handler.
public protocol TxDeeplinkCoordinatorProtocol {
    /// Processes a deep link URL by routing it to the appropriate handler.
    ///
    /// - Parameter url: The URL to process
    /// - Returns: `true` if the URL was handled, `false` otherwise
    @MainActor @discardableResult
    func handleURL(_ url: URL) -> Bool

    /// Checks if any handler can process the given URL.
    ///
    /// - Parameter url: The URL to check
    /// - Returns: `true` if any handler can process the URL, `false` otherwise
    func canOpenURL(_ url: URL) -> Bool
}

/// Coordinator for managing deep link handling in the application.
///
/// This struct:
/// - Maintains a list of deep link handlers
/// - Routes URLs to the appropriate handler
/// - Provides methods to check if URLs can be handled
public struct TxDeeplinkCoordinator: TxDeeplinkCoordinatorProtocol {
    /// The list of handlers that can process deep links.
    private let handlers: [TxDeeplinkHandlerProtocol]

    /// Creates a new coordinator with the given handlers.
    ///
    /// - Parameter handlers: The list of handlers to use
    public init(handlers: [TxDeeplinkHandlerProtocol]) {
        self.handlers = handlers
    }

    /// Processes a deep link URL by routing it to the appropriate handler.
    ///
    /// - Parameter url: The URL to process
    /// - Returns: `true` if the URL was handled, `false` otherwise
    @MainActor @discardableResult
    public func handleURL(_ url: URL) -> Bool {
        guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else {
            return false
        }

        handler.openURL(url)
        return true
    }

    /// Checks if any handler can process the given URL.
    ///
    /// - Parameter url: The URL to check
    /// - Returns: `true` if any handler can process the URL, `false` otherwise
    public func canOpenURL(_ url: URL) -> Bool {
        handlers.first(where: { $0.canOpenURL(url) }) != nil
    }
}
