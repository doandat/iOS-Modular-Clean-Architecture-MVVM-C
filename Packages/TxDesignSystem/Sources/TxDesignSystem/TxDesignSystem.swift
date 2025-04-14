//
//  TxDesignSystem.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import Foundation
import SwiftUI

/// Design system for the application.
///
/// This package provides:
/// - Common UI components
/// - Design tokens (colors, typography, spacing)
/// - Layout guidelines
/// - Accessibility support
public enum TxDesignSystem {}

/// Extension providing color system definitions
extension TxDesignSystem {
    /// Color system for the application.
    ///
    /// This extension provides:
    /// - Color palette definitions
    /// - Semantic color mappings
    /// - Dark/light mode support
    public enum Color {}
}

/// Extension providing UI component definitions
extension TxDesignSystem {
    /// UI components for the application.
    ///
    /// This extension provides:
    /// - Reusable UI components
    /// - Custom view modifiers
    /// - Layout components
    public enum UIComponent {}
}

/// Type aliases for design system components
public typealias TxColor = TxDesignSystem.Color
public typealias TxFont = TxDesignSystem.Fonts

/// Extension providing size system definitions
extension TxDesignSystem {
    /// Size system for the application.
    ///
    /// This extension provides:
    /// - Standard spacing values
    /// - Component dimensions
    /// - Layout constraints
    public enum Size {}
    
    /// Font system for the application.
    ///
    /// This extension provides:
    /// - Typography definitions
    /// - Font families
    /// - Text styles
    public struct Fonts {}
}

