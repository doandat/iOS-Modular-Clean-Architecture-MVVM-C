//
//  TxNavigationContainerView.swift
//  TxGitAdmin
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import UIKit
import Resolver

/// A SwiftUI wrapper for UINavigationController.
///
/// This struct provides:
/// - Navigation container for SwiftUI views
/// - Integration with UIKit navigation
/// - Custom navigation bar appearance
struct TxNavigationContainerView<Content: View>: UIViewControllerRepresentable {
    /// The root view to be displayed in the navigation controller
    let rootView: Content

    /// Creates a UINavigationController instance.
    ///
    /// - Parameter context: The context for creating the view controller
    /// - Returns: A configured UINavigationController
    func makeUIViewController(context: Context) -> UINavigationController {
        let hostingController = UIHostingController(rootView: rootView)
        var deeplinkService = Resolver.resolve(TxDeepLinksServiceProtocol.self)
        let navigationController = UINavigationController(rootViewController: hostingController)
        deeplinkService.rootViewController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
    }

    /// Updates the UINavigationController with new content.
    ///
    /// - Parameters:
    ///   - uiViewController: The navigation controller to update
    ///   - context: The context for updating
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // No updates needed
    }
}
