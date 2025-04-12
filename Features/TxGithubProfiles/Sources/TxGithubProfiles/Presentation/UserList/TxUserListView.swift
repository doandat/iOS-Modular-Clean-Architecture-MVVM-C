import SwiftUI
import Combine
import TxDesignSystem
import TxUIComponent
import TxTheme
import TxFoundation
import TxLogger
import TxLocalization

struct TxUserListView: TxView {
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
        //        .activityIndicator(isShowing: $viewModel.isLoading)
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
        case .error:
            errorView
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

    var errorView: some View {
        //        InterruptionDataView(message: nil) { viewModel.handleEvent(.refresh) }
        //            .accessibilityIdentifier(SettingsElementID.Security.errorView)
        EmptyView()
    }

    func userListView(users: [TxUserItemUIModel]) -> some View {
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
                            viewModel.gotoDetail(userId: user.id)
                        }
                }
                if viewModel.hasMoreData {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowInsets(.init())
                        .listRowSeparator(.hidden)
                        .onAppear {
                            viewModel.loadMoreData()
                        }
                }
            } footer: {
                Spacer().frame(height: TxSize.size400.rawValue)
            }.listSectionSeparator(.hidden)
        }
        .background(.clear)
        .listStyle(PlainListStyle())
        .refreshable {
            viewModel.loadInitialUsers() // Gọi làm mới dữ liệu
        }
        //        List(users) { user in
        //            TxUserItemView(user: user)
        //                .listRowInsets(
        //                    EdgeInsets(
        //                        top: TxSize.size400.rawValue,
        //                        leading: TxSize.size0.rawValue,
        //                        bottom: TxSize.size0.rawValue,
        //                        trailing: TxSize.size0.rawValue
        //                    )
        //                )
        //                .listRowSeparator(.hidden)
        //                .border(Color.clear)
        //                .background(.clear)
        //                .onTapGesture {
        //                    viewModel.gotoDetail(userId: user.id)
        //                }
        //        }
        ////        .padding(.bottom, 40)
        //        .background(.clear)
        //        .listStyle(PlainListStyle())
    }

}
