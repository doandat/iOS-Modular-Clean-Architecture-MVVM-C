//
//  TxThemeManager.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import Combine
import TxDesignSystem

/// Manager for theme colors in the application.
///
/// This class provides:
/// - Theme color management
/// - Theme switching
/// - Color state observation
public class TxThemeManager: ObservableObject {
    /// The currently selected theme color.
    @Published public var selectedColor: TxDesignSystem.ThemeColor

    /// Creates a new theme manager with light mode as default.
    public init() {
        self.selectedColor = .init(themeColorDTO: .darkMode)
    }

    /// Sets the current theme color.
    ///
    /// - Parameter color: The theme color to set
    public func setTheme(_ color: TxDesignSystem.ThemeColor) {
        selectedColor = color
    }

    public func switchSystemTheme(isDarkMode: Bool) {
        self.selectedColor = .init(themeColorDTO: isDarkMode ? .darkMode : .lightMode)
    }
}
