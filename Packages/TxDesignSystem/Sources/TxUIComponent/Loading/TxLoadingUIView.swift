//
//  TxLoadingView.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import UIKit
import TxTheme

/// A custom loading indicator view for UIKit.
///
/// This view provides:
/// - Activity indicator
/// - Background dimming
/// - Centered layout
final class TxLoadingUIView: UIView {
    /// The activity indicator view
    private let spinner = UIActivityIndicatorView(style: .large)
    
    /// Creates a new loading view with a frame.
    ///
    /// - Parameter frame: The frame for the view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    /// Creates a new loading view from a decoder.
    ///
    /// - Parameter coder: The decoder to use
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    /// Sets up the loading view.
    ///
    /// This method:
    /// - Configures the background
    /// - Sets up the activity indicator
    /// - Adds layout constraints
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
} 
