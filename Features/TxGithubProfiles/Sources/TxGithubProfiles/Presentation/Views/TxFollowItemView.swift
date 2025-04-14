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

/// A view component that displays a GitHub user's follower or following count with an icon.
///
/// This view presents:
/// - An icon representing followers or following
/// - The count of followers/following
/// - A label indicating the type of count
struct TxFollowItemView: View {
    @EnvironmentObject private var themeManager: TxThemeManager

    /// The icon to display (typically for followers or following).
    let icon: ImageResource

    /// The numerical value to display (e.g., "100" followers).
    let followValue: String

    /// The label text to display (e.g., "Followers" or "Following").
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
