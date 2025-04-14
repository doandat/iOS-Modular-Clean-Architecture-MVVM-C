import Combine
import Foundation
import SwiftUI
import Resolver
import TxApiClient
import TxLogger

final class TxUserListViewModel: ObservableObject {
    @Published private(set) var userListState: UserListState = .loading
    var users: [TxUserItemUIModel] = []
    private(set) var lastestUserId = 0
    var isLoading = false
    @Published var hasMoreData = false

    var hasData: Bool {
        return !users.isEmpty
    }

    @LazyInjected
    private var navigation: TxGithubProfileNavigation

    @Injected
    private var getUsersUseCase: TxGetUsersUseCase

    private var cancellables = Set<AnyCancellable>()

    init() {}

    @MainActor
    func loadInitialUsers() {
        guard !isLoading else { return }
        isLoading = true
        lastestUserId = 0
        Task { @MainActor in
            do {
                let apiClient = Resolver.resolve(TxApiClientProtocol.self)
                TxLogger().debug(apiClient)
                try await apiClient.performRequest(
                    action: {
                        let newUsers = try await getUsersUseCase.getUsers(
                            since: self.lastestUserId,
                            pageSize: TxGithubConstants.pageSize
                        )
                        self.users = newUsers.map { $0.toMapListUI() }
                        self.userListState = .data(self.users)
                        self.isLoading = false
                        if let lastestUserId = newUsers.last?.id {
                            self.lastestUserId = lastestUserId
                        }
                        self.hasMoreData = newUsers.count == TxGithubConstants.pageSize
                    },
                    loading: { [weak self] loading in
                        self?.isLoading = loading
                    },
                    alertErrorNetworkConnection: nil,
                    alertErrorNetworkCommon: nil,
                    onAlertNetworkAction: { [weak self] action, _ in
                        guard action == .retry else { return }
                        self?.loadInitialUsers()
                    })
            } catch {
                TxLogger().error(error)
                self.isLoading = false
                self.hasMoreData = false
                self.navigation.showAlert(
                    title: "githubprofile.alert.common.title".localization(),
                    message: "githubprofile.alert.common.error.message".localization(),
                    retryAction: { [weak self] in
                        self?.loadInitialUsers()
                    },
                    closeAction: {}
                )
            }
        }
    }

    @MainActor
    func loadMoreData() {
        guard !isLoading, hasMoreData else { return }
        isLoading = true

        Task { @MainActor in
            do {
                let apiClient = Resolver.resolve(TxApiClientProtocol.self)
                try await apiClient.performRequest(
                    action: { @MainActor in
                        let newUsers = try await getUsersUseCase.getUsers(
                            since: self.lastestUserId,
                            pageSize: TxGithubConstants.pageSize
                        )
                        self.users += newUsers.map { $0.toMapListUI() }
                        self.userListState = .data(self.users)
                        self.isLoading = false
                        if let lastestUserId = newUsers.last?.id {
                            self.lastestUserId = lastestUserId
                        }
                        self.hasMoreData = newUsers.count == TxGithubConstants.pageSize
                    },
                    loading: { [weak self] loading in
                        self?.isLoading = loading
                    },
                    alertErrorNetworkConnection: nil,
                    alertErrorNetworkCommon: nil,
                    onAlertNetworkAction: { [weak self] action, _ in
                        guard action == .retry else { return }
                        self?.loadMoreData()
                    })
            } catch {
                TxLogger().error(error)
                self.isLoading = false
                self.hasMoreData = false
                self.navigation.showAlert(
                    title: "githubprofile.alert.common.title".localization(),
                    message: "githubprofile.alert.common.error.message".localization(),
                    retryAction: { [weak self] in
                        self?.loadMoreData()
                    },
                    closeAction: {}
                )
            }
        }
    }

    @MainActor
    func gotoDetail(loginUsername: String) {
        navigation.routeToUserDetail(loginUsername: loginUsername)
    }
}

extension TxUserListViewModel {
    enum UserListState: Equatable {
        case loading
        case data([TxUserItemUIModel])

        static func == (lhs: UserListState, rhs: UserListState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case let (.data(lhsUsers), .data(rhsUsers)):
                return lhsUsers == rhsUsers
            default:
                return false
            }
        }
    }
}
