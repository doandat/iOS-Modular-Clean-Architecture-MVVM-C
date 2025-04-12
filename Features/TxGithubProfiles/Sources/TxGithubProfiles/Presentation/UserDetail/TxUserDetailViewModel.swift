import Combine
import Foundation
import SwiftUI
import Resolver

final class TxUserDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var user: TxUserDetailUIModel?
    @Published var errorMessage: String?
    var dataLoaded: Bool = false

    private let userId: String

    @LazyInjected
    private var navigation: TxGithubProfileNavigation

    @Injected
    private var getUserDetailUseCase: TxGetUserDetailUseCase

    private var cancellables = Set<AnyCancellable>()

    init(userId: String) {
        self.userId = userId
    }

    @MainActor
    func fetchUserDetail() {
        guard !isLoading else { return }
        isLoading = true
        Task { @MainActor in
            do {
                let user = try await getUserDetailUseCase.getUserDetail(userId: userId)
                self.user = user.toMapDetailUI()
                self.isLoading = false
                self.dataLoaded = true
            } catch {
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
