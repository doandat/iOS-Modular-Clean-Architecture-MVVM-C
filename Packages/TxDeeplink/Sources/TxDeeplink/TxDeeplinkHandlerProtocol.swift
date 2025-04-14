//
//  TxDeeplinkHandlerProtocol.swift
//  TxDeeplink
//
//  Created by doandat on 10/4/25.
//

import Foundation

/// Protocol defining the interface for handling deep links in the application.
///
/// This protocol is implemented by handlers that can process specific types of deep links.
/// Each handler is responsible for:
/// - Determining if it can handle a given URL
/// - Processing the URL and performing the appropriate navigation
public protocol TxDeeplinkHandlerProtocol {
    /// Checks if the handler can process the given URL.
    ///
    /// - Parameter url: The URL to check
    /// - Returns: `true` if the handler can process the URL, `false` otherwise
    func canOpenURL(_ url: URL) -> Bool
    
    /// Processes the URL and performs the appropriate navigation.
    ///
    /// - Parameter url: The URL to process
    @MainActor func openURL(_ url: URL)
}
