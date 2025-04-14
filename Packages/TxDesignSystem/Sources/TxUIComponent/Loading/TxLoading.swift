//
//  TxLoading.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import UIKit

/// Extension providing loading indicator functionality.
///
/// This extension provides:
/// - Loading indicator management
/// - Show/hide functionality
/// - Thread-safe operations
public extension TxLoading {
    /// Dismisses the loading indicator.
    ///
    /// This method:
    /// - Removes the loading indicator from view
    /// - Executes on the main thread
    class func dismiss() {
        DispatchQueue.main.async {
            shared.dismissHUD()
        }
    }

    /// Shows the loading indicator.
    ///
    /// This method:
    /// - Displays the loading indicator
    /// - Executes on the main thread
    class func show() {
        DispatchQueue.main.async {
            shared.setup()
        }
    }
}

// MARK: - TxLoading
/// A loading indicator component for UIKit.
///
/// This class provides:
/// - Full-screen loading overlay
/// - Activity indicator
/// - Background dimming
public class TxLoading: UIView {
    /// The background view for the loading indicator
    private var viewBackground: UIView?
    /// The loading indicator view
    private(set) var loadingView = TxLoadingUIView()
    /// The background color with alpha
    private var colorBackground = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    /// The shared instance of the loading indicator
    static let shared: TxLoading = {
        let instance = TxLoading()
        return instance
    }()

    /// Creates a new loading indicator with default frame.
    private convenience init() {
        self.init(frame: UIScreen.main.bounds)
        self.alpha = 0
        commonInit()
    }

    /// Creates a new loading indicator from a decoder.
    ///
    /// - Parameter coder: The decoder to use
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// Creates a new loading indicator with a frame.
    ///
    /// - Parameter frame: The frame for the loading indicator
    override private init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Common initialization for all initializers.
    ///
    /// This method:
    /// - Sets up the background
    /// - Sets up the toolbar
    private func commonInit() {
        setupBackground()
        setupToolbar()
    }
}

private extension TxLoading {
    /// Sets up the loading indicator.
    ///
    /// This method:
    /// - Configures the background
    /// - Prepares the loading view
    private func setup() {
        setupBackground()
    }
}

// MARK: - Background View
private extension TxLoading {
    /// Removes the background view.
    ///
    /// This method:
    /// - Removes the background from superview
    /// - Clears the background reference
    private func removeBackground() {
        viewBackground?.removeFromSuperview()
        viewBackground = nil
    }

    /// Sets up the background view.
    ///
    /// This method:
    /// - Finds the main window
    /// - Creates and configures the background
    /// - Adds constraints for full screen coverage
    private func setupBackground() {
        guard let mainWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })
        else {
            return
        }

        if viewBackground == nil {
            viewBackground = UIView(frame: mainWindow.frame)
            viewBackground?.backgroundColor = colorBackground
        }
        viewBackground?.removeFromSuperview()
        viewBackground?.translatesAutoresizingMaskIntoConstraints = false
        mainWindow.addSubview(viewBackground!)
        NSLayoutConstraint.activate([
            viewBackground!.leadingAnchor.constraint(equalTo: mainWindow.leadingAnchor),
            viewBackground!.trailingAnchor.constraint(equalTo: mainWindow.trailingAnchor),
            viewBackground!.topAnchor.constraint(equalTo: mainWindow.topAnchor),
            viewBackground!.bottomAnchor.constraint(equalTo: mainWindow.bottomAnchor)
        ])
    }
}

private extension TxLoading {
    /// Sets up the toolbar with the loading indicator.
    ///
    /// This method:
    /// - Configures the loading view
    /// - Adds it to the background
    /// - Centers it in the view
    private func setupToolbar() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        guard let viewBackground else { return }
        viewBackground.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: viewBackground.centerYAnchor)
        ])
    }
}

private extension TxLoading {
    /// Dismisses the loading indicator.
    ///
    /// This method:
    /// - Removes the background view
    /// - Cleans up resources
    private func dismissHUD() {
        viewBackground?.removeFromSuperview()
    }
}
