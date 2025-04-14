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
    @MainActor func routeToUserDetail(loginUsername: String)
    @MainActor func goBack()
    @MainActor func showAlert(
        title: String,
        message: String,
        retryAction: @escaping () -> Void,
        closeAction: @escaping () -> Void
    )
}
