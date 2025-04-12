import Combine
import Foundation
import SwiftUI
import Resolver

final class TxUserListViewModel: ObservableObject {
    @Published private(set) var userListState: UserListState = .loading
    var users: [TxUserItemUIModel] = []
    @Published var errorMessage: String?
    private var currentPage = 1
    @Published var isLoading = false
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
        currentPage = 1
        Task { @MainActor in
            do {
                let newUsers = try await getUsersUseCase.getUsers(
                    page: self.currentPage,
                    pageSize: TxGithubConstants.pageSize
                )
                self.users = newUsers.map { $0.toMapListUI() }
                self.userListState = .data(self.users)
                self.isLoading = false
                self.currentPage += 1
                self.hasMoreData = newUsers.count == TxGithubConstants.pageSize
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                self.hasMoreData = false
            }
        }
    }

    @MainActor
    func loadMoreData() {
        guard !isLoading, hasMoreData else { return }
        isLoading = true

        Task { @MainActor in
            do {
                let newUsers = try await getUsersUseCase.getUsers(
                    page: self.currentPage,
                    pageSize: TxGithubConstants.pageSize
                )
                self.users += newUsers.map { $0.toMapListUI() }
                self.userListState = .data(self.users)
                self.isLoading = false
                self.currentPage += 1
                self.hasMoreData = newUsers.count == TxGithubConstants.pageSize
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                self.hasMoreData = false
            }
        }
    }

    @MainActor
    func gotoDetail(userId: String) {
        navigation.routeToUserDetail(userId: userId)
    }
}

extension TxUserListViewModel {
    enum UserListState: Equatable {
        case loading
        case error(Error)
        case data([TxUserItemUIModel])

        static func == (lhs: UserListState, rhs: UserListState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.error, .error):
                return true
            case let (.data(lhsUsers), .data(rhsUsers)):
                return lhsUsers == rhsUsers
            default:
                return false
            }
        }
    }
}
