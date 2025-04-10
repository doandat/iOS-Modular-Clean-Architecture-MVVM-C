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
    public struct TxNavigationView: View {
        @EnvironmentObject var themeManager: TxThemeManager
        var title: String
        var actionBack: (() -> Void)?
        var backButtonIdentifier: String
        var titleIdentifier: String

        public init(title: String,
                    backButtonIdentifier: String = "",
                    titleIdentifier: String = "",
                    actionBack: (() -> Void)? = nil) {
            self.title = title
            self.actionBack = actionBack
            self.backButtonIdentifier = backButtonIdentifier
            self.titleIdentifier = titleIdentifier
        }

        public var body: some View {
            HStack(spacing: TxSize.size0.rawValue) {
                backButton
                titleView
            }
            .frame(height: TxSize.size1100.rawValue)
            .padding(.horizontal, TxSize.size400.rawValue)
        }

        private var backButton: some View {
            Image(.iconBack)
                .frame(width: TxSize.size1100.rawValue, height: TxSize.size1100.rawValue)
                .onTapGesture {
                    actionBack?()
                }
                .accessibilityIdentifier(backButtonIdentifier)
        }

        private var titleView: some View {
            Text(title)
                .modifier(TxFont.style(TxFont.Typography.titleSemibold(align: .center)))
                .foregroundColor(themeManager.selectedColor.textPrimary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.trailing, TxSize.size1100.rawValue)
                .accessibilityIdentifier(titleIdentifier)
        }
    }
}
