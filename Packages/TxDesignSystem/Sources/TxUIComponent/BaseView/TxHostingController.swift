//
//  TxHostingController.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import TxLogger

/// A custom UIHostingController for SwiftUI views.
///
/// This controller provides:
/// - SwiftUI view hosting
/// - Custom presentation handling
/// - Status bar configuration
public class TxHostingController<Content: View>: UIHostingController<Content> {
    public var identifier: String

    /// Creates a new hosting controller.
    ///
    /// - Parameter rootView: The SwiftUI view to host
    public override init(rootView: Content) {
        self.identifier = (rootView as? (any TxView))?.identifier ?? ""
        super.init(rootView: rootView)
    }

    /// Creates a new hosting controller from a decoder.
    ///
    /// - Parameter coder: The decoder to use
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        TxLogger().debug("deinit \(identifier)")
    }

    /// Configures the status bar style.
    ///
    /// - Returns: The preferred status bar style
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
