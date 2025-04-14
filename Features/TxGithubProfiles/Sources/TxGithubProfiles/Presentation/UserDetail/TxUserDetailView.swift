import SwiftUI
import Combine
import TxDesignSystem
import TxUIComponent
import TxTheme
import TxFoundation
import TxLogger
import TxLocalization

struct TxUserDetailView: TxView {
    var identifier: String = String(describing: Self.self)
    @ObservedObject var viewModel: TxUserDetailViewModel
    @EnvironmentObject private var l10n: L10n
    @EnvironmentObject private var themeManager: TxThemeManager

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TxDesignSystem.UIComponent.TxNavigationView(
                title: "githubprofile.user.detail.title".localization(),
                backButtonIdentifier: TxAccessibility.GithubProfiles.UserDetail.backButton,
                titleIdentifier: TxAccessibility.GithubProfiles.UserDetail.title
            ) {
                viewModel.goBack()
            }
            if let user = viewModel.user {
                TxUserItemView(user: user.baseInfo, type: .detail)
                    .padding(.vertical, TxSize.size400.rawValue)
                    .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserDetail.userCell)
                followView(user: user)
                    .padding(.horizontal, TxSize.size600.rawValue)
                    .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserDetail.followCell)
                blogView(user: user)
                    .padding(.horizontal, TxSize.size600.rawValue)
                    .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserDetail.blogCell)
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .bottom)
        .background(themeManager.selectedColor.backgroundWhite)
        .onAppear {
            guard !viewModel.dataLoaded else { return }
            viewModel.fetchUserDetail()
        }
    }

    func followView(user: TxUserDetailUIModel) -> some View {
        HStack(alignment: .center) {
            TxFollowItemView(
                icon: .iconUserGroup,
                followValue: user.followers,
                followLabel: "githubprofile.user.detail.follower".localization()
            ).accessibilityIdentifier(TxAccessibility.GithubProfiles.UserDetail.follower)

            TxFollowItemView(
                icon: .iconAchievement,
                followValue: user.following,
                followLabel: "githubprofile.user.detail.following".localization()
            ).accessibilityIdentifier(TxAccessibility.GithubProfiles.UserDetail.following)
        }
        .padding()
    }

    func blogView(user: TxUserDetailUIModel) -> some View {
        VStack(alignment: .leading) {
            Text("githubprofile.user.detail.blog".localization())
                .modifier(TxFont.style(TxFont.Typography.h4Medium()))
                .foregroundColor(themeManager.selectedColor.textPrimary)
                .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserDetail.blogTitle)
            Text(viewModel.user?.blogUrl ?? "")
                .modifier(TxFont.style(TxFont.Typography.baseRegular()))
                .foregroundColor(themeManager.selectedColor.textSecondary)
                .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserDetail.BlogLink)
        }
    }
}
