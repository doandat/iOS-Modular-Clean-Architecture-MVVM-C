//
//  TxDeeplinkHelper.swift
//  TxDeeplink
//
//  Created by doandat on 10/4/25.
//

import Foundation

/// Helper class for creating and managing deep link URLs.
///
/// This class provides utilities for:
/// - Creating deep link URLs with custom paths and parameters
/// - Converting string URLs to deep link format
/// - Creating deep links from enum types
public enum TxDeeplinkHelper {
    /// The schema used for deep links in the application.
    public static let APP_SCHEMA = "gitadmin-app"
    
    /// The host used for deep links in the application.
    public static let APP_HOST = "com.tx"

    /// Creates a deep link URL with the given path and parameters.
    ///
    /// - Parameters:
    ///   - path: The path component of the URL
    ///   - params: Optional query parameters
    /// - Returns: A URL constructed from the given components, or nil if construction fails
    public static func makeUrl(path: String, params: [String: Any?] = [:]) -> URL? {
        let queryItems: [URLQueryItem] = params.compactMap { key, value in
            guard let unwrappedValue = value else { return nil }
            return URLQueryItem(name: key, value: "\(unwrappedValue)")
        }
        var urlComponents = URLComponents()
        urlComponents.host = APP_HOST
        urlComponents.scheme = APP_SCHEMA
        urlComponents.path = path.starts(with: "/") ? path : "/\(path)"
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }

    /// Converts a string URL to the application's deep link format.
    ///
    /// - Parameter string: The URL string to convert
    /// - Returns: A URL in the application's deep link format, or nil if conversion fails
    public static func makeUrl(from string: String) -> URL? {
        var urlComponents = URLComponents(string: string)
        urlComponents?.host = APP_HOST
        urlComponents?.scheme = APP_SCHEMA
        return urlComponents?.url
    }

    /// Creates a deep link URL from an enum type and parameters.
    ///
    /// - Parameters:
    ///   - type: The enum type representing the deep link path
    ///   - params: Optional query parameters
    /// - Returns: A URL constructed from the enum type and parameters, or nil if construction fails
    public static func makeDeeplink(type: any RawRepresentable<String>, params: [String: Any?] = [:]) -> URL? {
        return makeUrl(path: type.rawValue, params: params)
    }
}
