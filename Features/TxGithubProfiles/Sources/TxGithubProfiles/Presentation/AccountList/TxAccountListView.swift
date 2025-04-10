import SwiftUI
import Combine
import TxDesignSystem
import TxUIComponent
import TxTheme
import TxFoundation
import TxLogger
import TxLocalization

struct TxAccountListView: TxView {
    var identifier: String = String(describing: Self.self)
    @ObservedObject var viewModel: TxAccountListViewModel
    @EnvironmentObject private var l10n: L10n
    @EnvironmentObject private var themeManager: TxThemeManager
    var body: some View {
        VStack(spacing: 0) {
            TxDesignSystem.UIComponent.TxNavigationView(
                title: l10n.localized(
                    key: "githubprofile.account.list.title",
                    in: Bundle.txGitProfile
                )
            )
            TxAccountItemView()
                .onTapGesture {
                    viewModel.gotoDetail()
                }
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .bottom)
        .background(themeManager.selectedColor.backgroundGray)
        .activityIndicator(isShowing: $viewModel.isLoading)
    }
}
