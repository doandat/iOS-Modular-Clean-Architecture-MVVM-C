//
//  TxGithubProfileNavigation.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import Foundation
import SwiftUI
import TxUIComponent

/// Protocol defining the navigation interface for the GitHub Profiles module.
///
/// This protocol outlines the navigation capabilities required by the module,
/// including screen transitions and alert presentations.
public protocol TxGithubProfileNavigation: AnyObject {
    /// Navigates to the user list screen.
    @MainActor func routeToUserlist()

    /// Navigates to the user detail screen for a specific user.
    ///
    /// - Parameter loginUsername: The GitHub username of the user to display details for.
    @MainActor func routeToUserDetail(loginUsername: String)

    /// Returns to the previous screen in the navigation stack.
    @MainActor func goBack()

    /// Displays an alert with retry and close options.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message to display in the alert.
    ///   - retryAction: The closure to execute when the retry button is tapped.
    ///   - closeAction: The closure to execute when the close button is tapped.
    @MainActor func showAlert(
        title: String,
        message: String,
        retryAction: @escaping () -> Void,
        closeAction: @escaping () -> Void
    )
}
