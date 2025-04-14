//
//  TxSession.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Alamofire
import Foundation

public class DefaultAlamofireSession: Alamofire.Session, @unchecked Sendable {
    public static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 240
        configuration.timeoutIntervalForResource = 240 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}
