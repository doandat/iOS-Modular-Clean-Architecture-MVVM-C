import Combine
import Foundation
import SwiftUI
import Resolver
import TxLogger
import TxApiClient

/// View model for managing the state and logic of the GitHub user detail screen.
///
/// This view model handles:
/// - Loading user detail data
/// - Error handling and retry logic
/// - Navigation back to previous screen
final class TxUserDetailViewModel: ObservableObject {
    /// Indicates whether the view model is currently loading data.
    @Published var isLoading: Bool = false
    
    /// The user detail data to display.
    @Published var user: TxUserDetailUIModel?
    
    /// Indicates whether the user data has been loaded.
    var dataLoaded: Bool = false
    
    /// The username of the user to fetch details for.
    private let loginUsername: String
    
    /// The navigation service for handling screen transitions.
    @LazyInjected
    private var navigation: TxGithubProfileNavigation
    
    /// The use case for fetching user details.
    @Injected
    private var getUserDetailUseCase: TxGetUserDetailUseCase
    
    /// Set of cancellables for managing subscriptions.
    private var cancellables = Set<AnyCancellable>()
    
    /// Creates a new view model instance.
    ///
    /// - Parameter loginUsername: The username of the user to fetch details for.
    init(loginUsername: String) {
        self.loginUsername = loginUsername
    }
    
    /// Fetches the user detail data.
    ///
    /// This method:
    /// - Checks if already loading to prevent duplicate requests
    /// - Makes an API request to fetch user details
    /// - Updates the UI state with the fetched data
    /// - Handles errors and shows appropriate alerts
    @MainActor
    func fetchUserDetail() {
        guard !isLoading else { return }
        isLoading = true
        Task { @MainActor in
            do {
                let apiClient = Resolver.resolve(TxApiClientProtocol.self)
                try await apiClient.performRequest(
                    action: { @MainActor in
                        let user = try await self.getUserDetailUseCase.getUserDetail(loginUsername: loginUsername)
                        self.user = user.toMapDetailUI()
                        self.isLoading = false
                        self.dataLoaded = true
                    }, loading: nil,
                    alertErrorNetworkConnection: nil,
                    alertErrorNetworkCommon: nil,
                    onAlertNetworkAction: { [weak self] action, _ in
                        self?.isLoading = false
                        guard action == .retry else { return }
                        self?.fetchUserDetail()
                    })
            } catch {
                TxLogger().error(error)
                self.navigation.showAlert(
                    title: "githubprofile.alert.common.title".localization(),
                    message: "githubprofile.alert.common.error.message".localization(),
                    retryAction: { [weak self] in
                        self?.fetchUserDetail()
                    },
                    closeAction: {}
                )
                self.isLoading = false
            }
        }
    }
    
    /// Navigates back to the previous screen.
    @MainActor
    func goBack() {
        navigation.goBack()
    }
}
