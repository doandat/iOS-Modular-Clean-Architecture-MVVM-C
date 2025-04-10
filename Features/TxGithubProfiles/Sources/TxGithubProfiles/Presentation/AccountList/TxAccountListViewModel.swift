import Combine
import Foundation
import SwiftUI
import Resolver

final class TxAccountListViewModel: ObservableObject {
    @Published var isLoading: Bool = false

    @LazyInjected
    private var navigation: TxGithubProfileNavigation

    private var cancellables = Set<AnyCancellable>()

    init() {

    }

    @MainActor func gotoDetail() {
        navigation.routeToAccountDetail()
    }
}
