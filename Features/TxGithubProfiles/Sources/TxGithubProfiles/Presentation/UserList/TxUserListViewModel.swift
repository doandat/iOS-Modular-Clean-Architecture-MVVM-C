import Combine
import Foundation
import SwiftUI
import Resolver
import TxApiClient
import TxLogger

/// View model for managing the state and logic of the GitHub user list screen.
///
/// This view model handles:
/// - Loading and pagination of user data
/// - Error handling and retry logic
/// - Navigation to user detail screens
final class TxUserListViewModel: ObservableObject {
    /// The current state of the user list.
    @Published private(set) var userListState: UserListState = .loading

    /// The list of users to display.
    var users: [TxUserItemUIModel] = []

    /// The ID of the last user in the current list, used for pagination.
    private(set) var lastestUserId = 0

    /// Indicates whether the view model is currently loading data.
    var isLoading = false

    /// Indicates whether there are more users to load.
    @Published var hasMoreData = false

    /// Checks if there is any user data available.
    var hasData: Bool {
        return !users.isEmpty
    }

    @LazyInjected
    private var navigation: TxGithubProfileNavigation

    @Injected
    private var getUsersUseCase: TxGetUsersUseCase

    private var cancellables = Set<AnyCancellable>()

    /// Creates a new view model instance.
    init() {}

    /// Loads the initial set of users.
    ///
    /// This method:
    /// - Resets the pagination state
    /// - Fetches the first page of users
    /// - Updates the UI state accordingly
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

    /// Loads more users for pagination.
    ///
    /// This method:
    /// - Fetches the next page of users
    /// - Appends them to the existing list
    /// - Updates the pagination state
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

    /// Navigates to the detail screen for a specific user.
    ///
    /// - Parameter loginUsername: The GitHub username of the user to display.
    @MainActor
    func gotoDetail(loginUsername: String) {
        navigation.routeToUserDetail(loginUsername: loginUsername)
    }
}

extension TxUserListViewModel {
    /// Represents the possible states of the user list.
    enum UserListState: Equatable {
        /// The list is currently loading data.
        case loading
        /// The list contains user data.
        case data([TxUserItemUIModel])

        /// Compares two user list states for equality.
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
