import SwiftUI
import Combine
import TxDesignSystem
import TxUIComponent
import TxTheme
import TxFoundation
import TxLogger
import TxLocalization

struct TxAccountDetailView: TxView {
    var identifier: String = String(describing: Self.self)
    @ObservedObject var viewModel: TxAccountDetailViewModel
    @EnvironmentObject private var l10n: L10n
    @EnvironmentObject private var themeManager: TxThemeManager

    var body: some View {
        VStack(spacing: 0) {
            TxDesignSystem.UIComponent.TxNavigationView(title: "githubprofile.account.detail.title".localization()) {
                viewModel.goBack()
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .bottom)
        .background(themeManager.selectedColor.backgroundGray)
        .activityIndicator(isShowing: $viewModel.isLoading)
    }
}
