//
//  TxEnvironmentValues.swift
//  TxFoundation
//
//  Created by doandat on 12/4/25.
//

import Foundation

/// Enum defining environment values and configuration for the application.
///
/// This enum provides:
/// - Environment type definitions (DEV, SIT, UAT, etc.)
/// - API host configuration
/// - Methods for accessing configuration values
public enum TxEnvironmentValues {
    /// Enum defining the available environment types.
    public enum EnvironmentType: String {
        /// Development environment
        case dev = "DEV"
        
        /// System Integration Testing environment
        case sit = "SIT"
        
        /// User Acceptance Testing environment
        case uat = "UAT"
        
        /// Pilot environment
        case pilot = "PILOT"
        
        /// Production environment
        case production = "PRODUCTION"
    }

    /// The current environment type of the application.
    @MainActor public static let environmentType = EnvironmentType(rawValue: rawConfiguration(forKey: "TX_ENV"))
    
    /// The API host URL for the current environment.
    @MainActor public private(set) static var apiHost: URL = makeUrl(from: rawConfiguration(forKey: "TX_API_HOST"))
}

extension TxEnvironmentValues {
    /// Retrieves a configuration value from the bundle's Info.plist.
    ///
    /// - Parameters:
    ///   - key: The configuration key to retrieve
    ///   - bundle: The bundle containing the configuration (defaults to main bundle)
    /// - Returns: The configuration value as a string
    /// - Throws: Fatal error if the key is not found
    private static func rawConfiguration(forKey key: String, in bundle: Bundle = .main) -> String {
        if let raw = bundle.object(forInfoDictionaryKey: key) as? String {
            return raw
        } else {
            fatalError("Unable to find configuration key: \(key)")
        }
    }

    /// Creates a URL from a host string.
    ///
    /// - Parameter host: The host string to convert to URL
    /// - Returns: A URL with https scheme and the given host
    /// - Throws: Fatal error if URL creation fails
    private static func makeUrl(from host: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = "https"

        if let url = urlComponents.url {
            return url
        } else {
            fatalError()
        }
    }
}
