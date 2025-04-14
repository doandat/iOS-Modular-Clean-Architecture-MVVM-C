import SwiftUI
import Combine
import TxDesignSystem
import TxUIComponent
import TxTheme
import TxFoundation
import TxLogger
import TxLocalization

struct TxUserListView: TxView {
    init(viewModel: TxUserListViewModel) {
        self.viewModel = viewModel
        TxLogger().debug("TxUserListView init")
    }
    var identifier: String = String(describing: Self.self)
    @ObservedObject var viewModel: TxUserListViewModel
    @EnvironmentObject private var l10n: L10n
    @EnvironmentObject private var themeManager: TxThemeManager

    var body: some View {
        VStack(spacing: 0) {
            TxDesignSystem.UIComponent.TxNavigationView(
                title: "githubprofile.user.list.title".localization()
            ).padding(.bottom, TxSize.size200.rawValue)
            contentView
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .bottom)
        .background(themeManager.selectedColor.backgroundWhite)
        .onAppear {
            guard !viewModel.hasData else { return }
            viewModel.loadInitialUsers()
        }
    }

    @ViewBuilder
    var contentView: some View {
        switch viewModel.userListState {
        case .loading:
            loadingView
        case .data(let users):
            userListView(users: users)
        }
    }

    private var loadingView: some View {
        Spacer()
            .shimmer(isLoading: true)
            .background(.white)
            .cornerRadius(TxSize.size300.rawValue)
            .frame(maxHeight: .infinity)
            .padding(TxSize.size400.rawValue)
    }

    @ViewBuilder
    func userListView(users: [TxUserItemUIModel]) -> some View {
        if users.isEmpty {
            Spacer()
            Text("githubprofile.user.list.empty".localization())
            Spacer()
        } else {
            List {
                Section {
                    ForEach(users) { user in
                        TxUserItemView(user: user, type: .list)
                            .listRowInsets(
                                EdgeInsets(
                                    top: TxSize.size200.rawValue,
                                    leading: TxSize.size0.rawValue,
                                    bottom: TxSize.size200.rawValue,
                                    trailing: TxSize.size0.rawValue
                                )
                            )
                            .listRowSeparator(.hidden)
                            .border(Color.clear)
                            .background(.clear)
                            .onTapGesture {
                                viewModel.gotoDetail(loginUsername: user.loginUsername)
                            }
                    }
                    loadingMoreView
                } footer: {
                    Spacer().frame(height: TxSize.size400.rawValue)
                }.listSectionSeparator(.hidden)
            }
            .background(.clear)
            .listStyle(PlainListStyle())
            .refreshable {
                viewModel.loadInitialUsers()
            }
        }
    }

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
        }
    }

}
