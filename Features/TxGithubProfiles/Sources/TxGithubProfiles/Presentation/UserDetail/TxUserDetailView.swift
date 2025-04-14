import SwiftUI
import Combine
import TxDesignSystem
import TxUIComponent
import TxTheme
import TxFoundation
import TxLogger
import TxLocalization

/// A view that displays detailed information about a GitHub user.
///
/// This view:
/// - Shows user's basic information
/// - Displays follower and following counts
/// - Shows user's blog URL
/// - Handles navigation and back button
struct TxUserDetailView: TxView {
    /// The unique identifier for this view.
    var identifier: String = String(describing: Self.self)

    /// The view model that manages the state and logic of the user detail.
    @ObservedObject var viewModel: TxUserDetailViewModel

    /// The localization environment object.
    @EnvironmentObject private var l10n: L10n

    /// The theme manager environment object.
    @EnvironmentObject private var themeManager: TxThemeManager

    /// The main content of the view.
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
        .background(themeManager.selectedColor.backgroundPrimary)
        .onAppear {
            guard !viewModel.dataLoaded else { return }
            viewModel.fetchUserDetail()
        }
    }

    /// Creates a view showing follower and following counts.
    ///
    /// - Parameter user: The user model containing follower and following data.
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

    /// Creates a view showing the user's blog URL.
    ///
    /// - Parameter user: The user model containing blog URL data.
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
