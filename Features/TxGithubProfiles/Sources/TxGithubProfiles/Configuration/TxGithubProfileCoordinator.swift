//
//  TxGithubProfileCoordinator.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import Foundation
import UIKit
import SwiftUI
import TxDesignSystem
import TxTheme
import TxFoundation
import TxUIComponent

public final class TxGithubProfileCoordinator {
    private let navigationController: UINavigationController

    public init(rootViewController: UINavigationController) {
        self.navigationController = rootViewController
    }
}

extension TxGithubProfileCoordinator: TxGithubProfileNavigation {
    @MainActor public static func getRootView() -> any TxView {
        let viewModel = TxAccountListViewModel()
        let contentView = TxAccountListView(viewModel: viewModel)
        return contentView
    }

    public func routeToAccountlist() {
        let viewModel = TxAccountListViewModel()
        let contentView = TxAccountListView(viewModel: viewModel)
        let controller = TxHostingController(rootView: contentView)
        self.navigationController.setViewControllers([controller], animated: false)
    }

    public func routeToAccountDetail() {
        let viewModel = TxAccountDetailViewModel()
        let contentView = TxAccountDetailView(viewModel: viewModel)
        let controller = TxHostingController(rootView: contentView)
        self.navigationController.pushViewController(controller, animated: true)
    }

    public func goBack() {
        self.navigationController.popViewController(animated: true)
    }
}
