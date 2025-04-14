//
//  TxFollowItemView.swift
//  TxGithubProfiles
//
//  Created by doandat on 12/4/25.
//

import SwiftUI
import TxDesignSystem
import TxTheme
import TxFont
import TxUIComponent

struct TxFollowItemView: View {
    @EnvironmentObject private var themeManager: TxThemeManager
    let icon: ImageResource
    let followValue: String
    let followLabel: String

    var body: some View {
        VStack(spacing: TxSize.size150.rawValue) {
            ZStack {
                Spacer()
                    .background(
                        themeManager.selectedColor.boderDefault)
                    .clipShape(Circle())
                Image(icon)
                    .resizable()
                    .foregroundColor(themeManager.selectedColor.textPrimary)
                    .padding(TxSize.size400.rawValue)
                    .accessibilityIdentifier(TxAccessibility.GithubProfiles.FlowItem.icon)
            }.frame(width: TxSize.size1600.rawValue, height: TxSize.size1600.rawValue)

            Text(followValue)
                .modifier(TxFont.style(TxFont.Typography.titleBold(align: .center)))
                .foregroundColor(themeManager.selectedColor.textPrimary)
                .accessibilityIdentifier(TxAccessibility.GithubProfiles.FlowItem.followValue)
            Text(followLabel)
                .modifier(TxFont.style(TxFont.Typography.baseRegular(align: .center)))
                .foregroundColor(themeManager.selectedColor.textSecondary)
                .accessibilityIdentifier(TxAccessibility.GithubProfiles.FlowItem.followLabel)
        }
        .frame(maxWidth: .infinity)
    }
}
