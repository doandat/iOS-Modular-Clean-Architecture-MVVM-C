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

public final class TxGithubProfileCoordinator {
    private let navigationController: UINavigationController
    
    public init(rootViewController: UINavigationController) {
        self.navigationController = rootViewController
    }
}

extension TxGithubProfileCoordinator: TxGithubProfileNavigation {
    @MainActor public static func getRootView() -> any TxView {
        let viewModel = TxUserListViewModel()
        let contentView = TxUserListView(viewModel: viewModel)
        return contentView
    }
    
    public func routeToUserlist() {
        let viewModel = TxUserListViewModel()
        let contentView = TxUserListView(viewModel: viewModel)
        let controller = TxHostingController(rootView: contentView)
        self.navigationController.setViewControllers([controller], animated: false)
    }
    
    public func routeToUserDetail(loginUsername: String) {
        let viewModel = TxUserDetailViewModel(loginUsername: loginUsername)
        let contentView = TxUserDetailView(viewModel: viewModel)
        let controller = TxHostingController(rootView: contentView)
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    public func goBack() {
        self.navigationController.popViewController(animated: true)
    }
    
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
