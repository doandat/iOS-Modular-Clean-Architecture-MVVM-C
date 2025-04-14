//
//  TxGitAdminApp+setup.swift
//  TxGitAdmin
//
//  Created by doandat on 13/4/25.
//
import SwiftUI
import Resolver
import TxDesignSystem
import TxTheme
import TxFont
import TxApiClient
import TxLogger
import TxUIComponent
import TxDeeplink
import TxGithubProfiles
import TxLocalization
import TxNetworkModels

#if DEBUG
import Atlantis
#endif

extension TxGitAdminApp {
    func setupDebug() {
#if DEBUG
        Atlantis.start()
#endif
    }
    func setupDI() {
        Resolver.register { TxThemeManager() }.scope(ResolverScope.application)
        Resolver.register { L10n() }.scope(ResolverScope.application)
        Resolver.register { TxApiClient() }.scope(ResolverScope.application)
        Resolver.register { TxDeepLinksService() as TxDeepLinksServiceProtocol }.scope(ResolverScope.application)
        TxGithubProfiles.Configuration().register()
    }

    func setupNetwork() {
        let l10n = Resolver.resolve(L10n.self)
        let apiClient = Resolver.resolve(TxApiClient.self)
        
        apiClient.onLoading = { @MainActor isLoading in
            TxLogger().debug("isLoading: \(isLoading)")
            if isLoading {
                TxLoading.show()
            } else {
                TxLoading.dismiss()
            }
        }

        apiClient.alertErrorNetworkCommon = {
            @MainActor networkError,
            onAlertNetworkAction in
            TxLogger().debug("alertErrorNetworkCommon: \(networkError)")
            self.showAlert(
                title: l10n.localized(
                    key: "main.alert.common.title",
                    in: .main
                ),
                message: networkError.getErrorDetails(),
                retryAction: {
                    onAlertNetworkAction(.retry)
                }, closeAction: {
                    onAlertNetworkAction(.cancel)
                })
        }

        apiClient.alertErrorNetworkConnection = { @MainActor networkError, onAlertNetworkAction in
            TxLogger().debug("alertErrorNetworkConnection: \(networkError)")
            self.showAlert(title: l10n.localized(
                key: "main.alert.common.title",
                in: .main
            ), message: networkError.getErrorDetails(), retryAction: {
                onAlertNetworkAction(.retry)
            }, closeAction: {
                onAlertNetworkAction(.cancel)
            })
        }
    }
}

extension TxGitAdminApp {
    func showAlert(
        title: String,
        message: String,
        retryAction: @escaping () -> Void,
        closeAction: @escaping () -> Void
    ) {
        let l10n = Resolver.resolve(L10n.self)
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: l10n.localized(
            key: "main.alert.common.retry",
            in: .main
        ), style: .default, handler: { _ in
            retryAction()
        }))
        
        alert.addAction(UIAlertAction(title: l10n.localized(
            key: "main.alert.common.close",
            in: .main
        ), style: .cancel, handler: { _ in
            closeAction()
        }))
        
        let deeplinkService = Resolver.resolve(TxDeepLinksServiceProtocol.self)
        deeplinkService.rootViewController?.present(alert, animated: false, completion: nil)

    }
}

extension TxResponseError.NetworkErrorType {
    public func getErrorDetails() -> String {
        let l10n = Resolver.resolve(L10n.self)
        switch self {
        case .noNetworkConnection:
            return l10n.localized(
                key: "main.alert.common.network.no.connection",
                in: .main
            )
        case .requestTimeout:
            return l10n.localized(
                key: "main.alert.common.network.time.out",
                in: .main
            )
        case .unknown:
            return l10n.localized(
                key: "main.alert.common.error.message",
                in: .main
            )
        }
    }
}

extension TxResponseError {
    public func getErrorDetails() -> String {
        let l10n = Resolver.resolve(L10n.self)
        switch self.errorType {
        case .network(let networkErrorType):
            return networkErrorType.getErrorDetails()
        default:
            guard let message else {
                return l10n.localized(
                    key: "main.alert.common.error.message",
                    in: .main
                )
            }
            return message
        }
    }
}
