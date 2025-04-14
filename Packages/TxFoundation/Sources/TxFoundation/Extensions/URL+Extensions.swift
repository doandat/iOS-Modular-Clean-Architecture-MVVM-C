//
//  URL+Extensions.swift
//  TxFoundation
//
//  Created by doandat on 4/4/25.
//

import Foundation

/// Extension providing additional functionality for URL.
public extension URL {
    /// Creates a URL with the given path and query parameters.
    ///
    /// - Parameters:
    ///   - path: The path component of the URL
    ///   - params: Optional query parameters
    /// - Returns: A URL constructed from the given components, or nil if construction fails
    static func makeUrl(path: String, params: [String: Any?] = [:]) -> URL? {
        let queryItems: [URLQueryItem] = params.compactMap { key, value in
            guard let unwrappedValue = value else { return nil }
            return URLQueryItem(name: key, value: "\(unwrappedValue)")
        }
        var urlComponents = URLComponents()
        urlComponents.path = path.starts(with: "/") ? path : "/\(path)"
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }

    /// Parses the query parameters from the URL into a dictionary.
    ///
    /// This method:
    /// - Extracts all query items from the URL
    /// - Converts them into a dictionary of key-value pairs
    /// - Returns an empty dictionary if no query parameters exist
    ///
    /// - Returns: A dictionary containing the query parameters, where:
    ///   - Keys are the parameter names
    ///   - Values are the parameter values as strings
    func parseQueryParameters() -> [String: String] {
        guard let queryItems = URLComponents(
            url: self,
            resolvingAgainstBaseURL: false
        )?.queryItems else {
            return [:]
        }
        var parameters = [String: String]()
        for queryItem in queryItems {
            parameters[queryItem.name] = queryItem.value
        }
        return parameters
    }
}

