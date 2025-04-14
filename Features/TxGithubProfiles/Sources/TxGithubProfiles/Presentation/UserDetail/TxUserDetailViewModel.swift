import Combine
import Foundation
import SwiftUI
import Resolver
import TxLogger
import TxApiClient

final class TxUserDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var user: TxUserDetailUIModel?
    @Published var errorMessage: String?
    var dataLoaded: Bool = false

    private let loginUsername: String

    @LazyInjected
    private var navigation: TxGithubProfileNavigation

    @Injected
    private var getUserDetailUseCase: TxGetUserDetailUseCase

    private var cancellables = Set<AnyCancellable>()

    init(loginUsername: String) {
        self.loginUsername = loginUsername
    }

    @MainActor
    func fetchUserDetail() {
        guard !isLoading else { return }
        isLoading = true
        Task { @MainActor in
            do {
                let apiClient = Resolver.resolve(TxApiClient.self)
                try await apiClient.performRequest(action: { @MainActor in
                    let user = try await self.getUserDetailUseCase.getUserDetail(loginUsername: loginUsername)
                    self.user = user.toMapDetailUI()
                    self.isLoading = false
                    self.dataLoaded = true
                })
            } catch {
                TxLogger().error(error)
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }

    @MainActor
    func goBack() {
        navigation.goBack()
    }
}
