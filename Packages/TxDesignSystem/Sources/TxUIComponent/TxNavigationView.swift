//
//  TxNavigationView.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import TxDesignSystem
import TxFont
import TxTheme

extension TxDesignSystem.UIComponent {
    /// A custom navigation view component.
    ///
    /// This view provides:
    /// - Custom navigation bar appearance
    /// - Back button with action
    /// - Title display with styling
    /// - Accessibility identifiers
    public struct TxNavigationView: View {
        /// The theme manager for styling
        @EnvironmentObject var themeManager: TxThemeManager
        /// The title to display
        var title: String
        /// The action to perform when back button is tapped
        var actionBack: (() -> Void)?
        /// The accessibility identifier for the back button
        var backButtonIdentifier: String
        /// The accessibility identifier for the title
        var titleIdentifier: String

        /// Creates a new navigation view.
        ///
        /// - Parameters:
        ///   - title: The title to display
        ///   - backButtonIdentifier: The accessibility identifier for the back button
        ///   - titleIdentifier: The accessibility identifier for the title
        ///   - actionBack: The action to perform when back button is tapped
        public init(title: String,
                    backButtonIdentifier: String = "",
                    titleIdentifier: String = "",
                    actionBack: (() -> Void)? = nil) {
            self.title = title
            self.actionBack = actionBack
            self.backButtonIdentifier = backButtonIdentifier
            self.titleIdentifier = titleIdentifier
        }

        /// The body of the navigation view.
        ///
        /// This view:
        /// - Displays a back button
        /// - Shows the title
        /// - Applies custom styling
        public var body: some View {
            HStack(spacing: TxSize.size0.rawValue) {
                backButton
                titleView
            }
            .frame(height: TxSize.size1100.rawValue)
            .padding(.horizontal, TxSize.size400.rawValue)
        }

        /// The back button view.
        ///
        /// This view:
        /// - Displays a back icon
        /// - Handles tap gestures
        /// - Supports accessibility
        private var backButton: some View {
            Image(.iconBack)
                .frame(width: TxSize.size1100.rawValue, height: TxSize.size1100.rawValue)
                .foregroundColor(themeManager.selectedColor.textPrimary)
                .onTapGesture {
                    actionBack?()
                }
                .accessibilityIdentifier(backButtonIdentifier)
        }

        /// The title view.
        ///
        /// This view:
        /// - Displays the title text
        /// - Applies typography styling
        /// - Supports accessibility
        private var titleView: some View {
            Text(title)
                .modifier(TxFont.style(TxFont.Typography.h4SemiBold(align: .center)))
                .foregroundColor(themeManager.selectedColor.textPrimary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.trailing, TxSize.size1100.rawValue)
                .accessibilityIdentifier(titleIdentifier)
        }
    }
}
