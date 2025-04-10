//
//  TxDeeplinkHandlerProtocol.swift
//  TxDeeplink
//
//  Created by doandat on 10/4/25.
//

import Foundation

public protocol TxDeeplinkHandlerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    @MainActor func openURL(_ url: URL)
}
