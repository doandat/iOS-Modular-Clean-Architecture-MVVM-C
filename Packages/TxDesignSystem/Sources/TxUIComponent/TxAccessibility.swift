//
//  TxAccessibility.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import Foundation
import SwiftUI

/// Accessibility support for UI components.
///
/// This file provides:
/// - Accessibility labels and hints
/// - VoiceOver support
/// - Dynamic Type support
/// - Color contrast requirements
public enum TxAccessibility {}

extension TxAccessibility {
    public enum BaseView {}
}

/// Accessibility identifiers for UI components.
///
/// This enum provides:
/// - Consistent accessibility identifiers
/// - Easy reference for UI testing
/// - Organized by component type
extension TxAccessibility {
    /// Navigation bar identifiers
    public enum Navigation {
        /// Back button identifier
        public static let backButton = "navigation_back_button"
        /// Title identifier
        public static let title = "navigation_title"
        /// Subtitle identifier
        public static let subtitle = "navigation_subtitle"
        /// Right button identifier
        public static let rightButton = "navigation_right_button"
    }
}
