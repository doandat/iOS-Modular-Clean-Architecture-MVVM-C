//
//  TxUserItemView.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import NukeUI
import TxDesignSystem
import TxUIComponent
import TxTheme
import TxFont

struct TxUserItemView: View {
    @EnvironmentObject private var themeManager: TxThemeManager

    let user: TxUserItemUIModel
    let type: UserUIType

    var body: some View {
        HStack(spacing: TxSize.size300.rawValue) {
            avatarView
            infoView
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .modifier(TxBoxBorderModifier())
//        .background(.gray)
        .padding(.horizontal, TxSize.size600.rawValue)
    }

    var avatarView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: TxSize.size300.rawValue)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 100, height: 100)
            LazyImage(url: URL(string: user.avatarUrl)) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if state.error != nil {
                    avatarPlaceholder
                } else {
                    avatarPlaceholder
                }
            }
            .frame(width: 90, height: 90)
            .clipShape(Circle())
            .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserItem.avatar)
        }
    }

    var avatarPlaceholder: some View {
        ZStack {
            Spacer()
                .background(.purple.opacity(0.1))
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray.opacity(0.8))
                .padding(TxSize.size500.rawValue)
        }
    }

    var infoView: some View {
        VStack(alignment: .leading, spacing: TxSize.size200.rawValue) {
            Text(user.name)
                .modifier(TxFont.style(TxFont.Typography.titleSemibold()))
                .foregroundColor(themeManager.selectedColor.textPrimary)
                .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserItem.name)
            switch type {
            case .list:
                if !user.landingPageUrl.isEmpty {
                    Divider()
                    Text(user.landingPageUrl)
                        .underline()
                        .modifier(TxFont.style(TxFont.Typography.smallRegular()))
                        .foregroundColor(.blue)
                        .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserItem.landingPageUrl)
                }
            case .detail:
                if !user.location.isEmpty {
                    Divider()
                    HStack(spacing: TxSize.size100.rawValue) {
                        Image(.iconLocation)
                            .resizable()
                            .frame(width: TxSize.size400.rawValue, height: TxSize.size400.rawValue)
                            .foregroundColor(themeManager.selectedColor.textSecondary)
                        Text(user.location)
                            .modifier(TxFont.style(TxFont.Typography.smallRegular()))
                            .foregroundColor(themeManager.selectedColor.textSecondary)
                            .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserItem.location)
                    }
                }
            }
            Spacer()
        }
        .frame(maxHeight: 100, alignment: .top)
    }
}

extension TxUserItemView {
    enum UserUIType {
        case list
        case detail
    }
}

struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        TxUserItemView(
            user: TxGithubUser(
                id: 1,
                name: "David",
                username: "David Patel",
                avatarUrl: "user_avatar",
                landingPageUrl: "https://www.linkedin.com/",
                location: "Vietnam",
                followers: 100,
                following: 10,
                blogUrl: "https://blog.abc"
            ).toMapListUI(),
            type: .list
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
