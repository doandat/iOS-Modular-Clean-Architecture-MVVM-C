//
//  TxSession.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Alamofire
import Foundation

/// A custom Alamofire session configuration for network requests.
///
/// This class provides a shared session instance with custom configuration:
/// - Default headers
/// - 240-second timeout for both requests and resources
/// - Protocol-based cache policy
public class DefaultAlamofireSession: Alamofire.Session, @unchecked Sendable {
    /// Shared instance of the session with custom configuration.
    ///
    /// The configuration includes:
    /// - Default headers
    /// - 240-second timeout intervals
    /// - Protocol-based cache policy
    public static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 240
        configuration.timeoutIntervalForResource = 240 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}
