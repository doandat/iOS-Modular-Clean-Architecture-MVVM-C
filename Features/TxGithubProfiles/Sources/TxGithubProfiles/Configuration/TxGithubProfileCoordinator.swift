//
//  TxGithubProfileCoordinator.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import Foundation
import UIKit
import SwiftUI
import Resolver
import TxDesignSystem
import TxTheme
import TxFoundation
import TxUIComponent
import TxLocalization

/// Coordinator class responsible for managing navigation flow in the GitHub Profiles module.
///
/// This coordinator handles:
/// - Navigation between different screens (user list, user detail)
/// - Presentation of alerts and error messages
/// - Root view setup
public final class TxGithubProfileCoordinator {
    private let navigationController: UINavigationController

    /// Creates a new coordinator instance with the specified navigation controller.
    ///
    /// - Parameter rootViewController: The navigation controller that will handle view transitions.
    public init(rootViewController: UINavigationController) {
        self.navigationController = rootViewController
    }
}

extension TxGithubProfileCoordinator: TxGithubProfileNavigation {
    /// Creates and returns the root view of the GitHub Profiles module.
    ///
    /// - Returns: A view that displays the list of GitHub users.
    @MainActor public static func getRootView() -> any TxView {
        let viewModel = TxUserListViewModel()
        let contentView = TxUserListView(viewModel: viewModel)
        return contentView
    }

    /// Navigates to the user list screen.
    ///
    /// This method replaces the current view controller stack with the user list view.
    public func routeToUserlist() {
        let viewModel = TxUserListViewModel()
        let contentView = TxUserListView(viewModel: viewModel)
        let controller = TxHostingController(rootView: contentView)
        self.navigationController.setViewControllers([controller], animated: false)
    }

    /// Navigates to the user detail screen for a specific user.
    ///
    /// - Parameter loginUsername: The GitHub username of the user to display details for.
    public func routeToUserDetail(loginUsername: String) {
        let viewModel = TxUserDetailViewModel(loginUsername: loginUsername)
        let contentView = TxUserDetailView(viewModel: viewModel)
        let controller = TxHostingController(rootView: contentView)
        self.navigationController.pushViewController(controller, animated: true)
    }

    /// Returns to the previous screen in the navigation stack.
    public func goBack() {
        self.navigationController.popViewController(animated: true)
    }

    /// Displays an alert with retry and close options.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message to display in the alert.
    ///   - retryAction: The closure to execute when the retry button is tapped.
    ///   - closeAction: The closure to execute when the close button is tapped.
    public func showAlert(
        title: String,
        message: String,
        retryAction: @escaping () -> Void,
        closeAction: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(
            UIAlertAction(
                title: "githubprofile.alert.common.retry".localization(),
                style: .default,
                handler: { _ in
                    retryAction()
                })
        )

        alert.addAction(
            UIAlertAction(
                title: "githubprofile.alert.common.close".localization(),
                style: .cancel,
                handler: { _ in
                    closeAction()
                })
        )

        self.navigationController.present(alert, animated: false, completion: nil)
    }
}
