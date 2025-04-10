//
//  TxDeeplinkCoordinator.swift
//  TxDeeplink
//
//  Created by doandat on 10/4/25.
//

import Foundation

public protocol TxDeeplinkCoordinatorProtocol {
    @MainActor @discardableResult
    func handleURL(_ url: URL) -> Bool

    func canOpenURL(_ url: URL) -> Bool
}

public struct TxDeeplinkCoordinator: TxDeeplinkCoordinatorProtocol {
    private let handlers: [TxDeeplinkHandlerProtocol]

    public init(handlers: [TxDeeplinkHandlerProtocol]) {
        self.handlers = handlers
    }

    @MainActor @discardableResult
    public func handleURL(_ url: URL) -> Bool {
        guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else {
            return false
        }

        handler.openURL(url)
        return true
    }

    public func canOpenURL(_ url: URL) -> Bool {
        handlers.first(where: { $0.canOpenURL(url) }) != nil
    }
}
