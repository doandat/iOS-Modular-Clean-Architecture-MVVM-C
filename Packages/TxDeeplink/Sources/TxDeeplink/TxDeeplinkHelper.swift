//
//  TxDeeplinkHelper.swift
//  TxDeeplink
//
//  Created by doandat on 10/4/25.
//

import Foundation

public enum TxDeeplinkHelper {
    public static let APP_SCHEMA = "gitadmin-app"
    public static let APP_HOST = "com.tx"

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

    public static func makeUrl(from string: String) -> URL? {
        var urlComponents = URLComponents(string: string)
        urlComponents?.host = APP_HOST
        urlComponents?.scheme = APP_SCHEMA
        return urlComponents?.url
    }

    public static func makeDeeplink(type: any RawRepresentable<String>, params: [String: Any?] = [:]) -> URL? {
        return makeUrl(path: type.rawValue, params: params)
    }

}
