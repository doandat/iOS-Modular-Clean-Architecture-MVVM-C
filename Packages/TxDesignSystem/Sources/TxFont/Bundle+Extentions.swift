//
//  Bundle+Extentions.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import UIKit

/// Extension providing font bundle access.
///
/// This extension provides:
/// - Access to the font bundle
/// - Font resource management
extension Bundle {
    /// The font bundle containing font resources.
    ///
    /// This property:
    /// - Provides access to font files
    /// - Used for font registration
    public static let txFont: Bundle = {
        Bundle.module
    }()
}
