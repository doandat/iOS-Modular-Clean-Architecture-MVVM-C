//
//  TxEnvironmentValues.swift
//  TxFoundation
//
//  Created by doandat on 12/4/25.
//

import Foundation

public enum TxEnvironmentValues {
    public enum EnvironmentType: String {
        case dev = "DEV"
        case sit = "SIT"
        case uat = "UAT"
        case pilot = "PILOT"
        case production = "PRODUCTION"
    }

    @MainActor public static let environmentType = EnvironmentType(rawValue: rawConfiguration(forKey: "TX_ENV"))
    @MainActor public private(set) static var apiHost: URL = makeUrl(from: rawConfiguration(forKey: "TX_API_HOST"))

}

extension TxEnvironmentValues {
    private static func rawConfiguration(forKey key: String, in bundle: Bundle = .main) -> String {
        if let raw = bundle.object(forInfoDictionaryKey: key) as? String {
            return raw
        } else {
            fatalError("Unable to find configuration key: \(key)")
        }
    }

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
