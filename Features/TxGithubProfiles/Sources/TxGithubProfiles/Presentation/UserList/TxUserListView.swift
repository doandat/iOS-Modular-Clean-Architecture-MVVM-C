import SwiftUI
import Combine
import TxDesignSystem
import TxUIComponent
import TxTheme
import TxFoundation
import TxLogger
import TxLocalization

/// A view that displays a list of GitHub users.
///
/// This view:
/// - Shows a loading state while fetching users
/// - Displays the list of users with pagination
/// - Handles empty state
/// - Provides pull-to-refresh functionality
/// - Navigates to user detail on tap
struct TxUserListView: TxView {
    /// The unique identifier for this view.
    var identifier: String = String(describing: Self.self)

    /// The view model that manages the state and logic of the user list.
    @ObservedObject var viewModel: TxUserListViewModel

    /// The localization environment object.
    @EnvironmentObject private var l10n: L10n

    /// The theme manager environment object.
    @EnvironmentObject private var themeManager: TxThemeManager

    /// Creates a new user list view.
    ///
    /// - Parameter viewModel: The view model to use for managing the user list.
    init(viewModel: TxUserListViewModel) {
        self.viewModel = viewModel
        TxLogger().debug("TxUserListView init")
    }

    /// The main content of the view.
    var body: some View {
        VStack(spacing: 0) {
            TxDesignSystem.UIComponent.TxNavigationView(
                title: "githubprofile.user.list.title".localization(),
                backButtonIdentifier: TxAccessibility.GithubProfiles.UserList.backButton,
                titleIdentifier: TxAccessibility.GithubProfiles.UserList.title
            ).padding(.bottom, TxSize.size200.rawValue)
            contentView
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .bottom)
        .background(themeManager.selectedColor.backgroundPrimary)
        .onAppear {
            guard !viewModel.hasData else { return }
            viewModel.loadInitialUsers()
        }
    }

    /// The content view that displays either loading state or user list.
    @ViewBuilder
    var contentView: some View {
        switch viewModel.userListState {
        case .loading:
            loadingView
        case .data(let users):
            userListView(users: users)
        }
    }

    /// The loading view that shows a shimmer effect.
    private var loadingView: some View {
        Spacer()
            .shimmer(isLoading: true)
            .background(.white)
            .cornerRadius(TxSize.size300.rawValue)
            .frame(maxHeight: .infinity)
            .padding(TxSize.size400.rawValue)
            .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserList.shimmer)
    }

    /// The view that displays the list of users.
    ///
    /// - Parameter users: The list of users to display.
    @ViewBuilder
    func userListView(users: [TxUserItemUIModel]) -> some View {
        if users.isEmpty {
            Spacer()
            Text("githubprofile.user.list.empty".localization())
                .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserList.empty)
            Spacer()
        } else {
            List {
                Section {
                    ForEach(users) { user in
                        TxUserItemView(user: user, type: .list)
                            .background(.clear)
                            .listRowInsets(
                                EdgeInsets(
                                    top: TxSize.size200.rawValue,
                                    leading: TxSize.size0.rawValue,
                                    bottom: TxSize.size200.rawValue,
                                    trailing: TxSize.size0.rawValue
                                )
                            )
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .border(Color.clear)
                            .onTapGesture {
                                viewModel.gotoDetail(loginUsername: user.loginUsername)
                            }
                            .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserList.userCell)
                    }
                    loadingMoreView
                        .listRowBackground(Color.clear)
                } footer: {
                    Spacer()
                        .frame(height: TxSize.size400.rawValue)
                        .listRowBackground(Color.clear)
                }
                .listSectionSeparator(.hidden)
                .background(.clear)
            }
            .background(.clear)
            .listStyle(PlainListStyle())
            .refreshable {
                viewModel.loadInitialUsers()
            }
            .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserList.list)
        }
    }

    /// The view that shows loading state when fetching more users.
    @ViewBuilder
    var loadingMoreView: some View {
        if viewModel.hasMoreData {
            TxLoadingMoreView(message: "githubprofile.user.list.loading.more".localization())
                .listRowInsets(
                    EdgeInsets(
                        top: TxSize.size200.rawValue,
                        leading: TxSize.size0.rawValue,
                        bottom: TxSize.size200.rawValue,
                        trailing: TxSize.size0.rawValue
                    )
                )
                .listRowSeparator(.hidden)
                .onAppear {
                    viewModel.loadMoreData()
                }
                .accessibilityIdentifier(TxAccessibility.GithubProfiles.UserList.loadMore)
        }
    }
}
