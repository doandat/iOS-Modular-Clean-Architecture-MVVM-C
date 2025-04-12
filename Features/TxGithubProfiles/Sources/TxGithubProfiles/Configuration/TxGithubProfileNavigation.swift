//
//  TxGithubProfileNavigation.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import Foundation
import SwiftUI
import TxUIComponent

public protocol TxGithubProfileNavigation: AnyObject {
    @MainActor func routeToUserlist()
    @MainActor func routeToUserDetail(userId: String)
    @MainActor func goBack()
}
