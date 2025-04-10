//
//  TxNavigationContainerView.swift
//  TxGitAdmin
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import UIKit

struct TxNavigationContainerView<Content: View>: UIViewControllerRepresentable {
    let rootView: Content

    func makeUIViewController(context: Context) -> UINavigationController {
        let hostingController = UIHostingController(rootView: rootView)
        let navigationController = UINavigationController(rootViewController: hostingController)
        DeepLinksService.shared.rootViewController = navigationController

        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}
