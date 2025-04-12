//
//  URL+Extensions.swift
//  TxFoundation
//
//  Created by doandat on 12/4/25.
//

import Foundation

public extension URL {
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

