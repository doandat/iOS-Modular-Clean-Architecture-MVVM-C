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
    /// Sets up debug tools and configurations for development builds.
    ///
    /// This method:
    /// - Starts Atlantis for network debugging in DEBUG builds
    /// - Does nothing in release builds
    func setupDebug() {
#if DEBUG
        Atlantis.start()
#endif
    }

    /// Sets up dependency injection for the application.
    ///
    /// This method registers:
    /// - Theme manager for application-wide theming
    /// - Localization service for text translations
    /// - API client for network requests
    /// - Deep linking service for handling deep links
    /// - GitHub profiles configuration
    func setupDI() {
        Resolver.register { TxThemeManager() }.scope(ResolverScope.application)
        Resolver.register { L10n() }.scope(ResolverScope.application)
        let apiClient = TxApiClient()
        Resolver.register { apiClient }.scope(ResolverScope.application)
        Resolver.register { apiClient as TxApiClientProtocol }.scope(ResolverScope.application)
        Resolver.register { TxDeepLinksService() as TxDeepLinksServiceProtocol }.scope(ResolverScope.application)
        TxGithubProfiles.Configuration().register()
    }

    /// Configures network-related settings and error handling.
    ///
    /// This method:
    /// - Sets up loading indicator for network requests
    /// - Configures common network error handling
    /// - Sets up network connection error handling
    func setupNetwork() {
        let l10n = Resolver.resolve(L10n.self)
        let apiClient: TxApiClient = Resolver.resolve(TxApiClient.self)
        
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
    /// Displays an alert with retry and close options.
    ///
    /// - Parameters:
    ///   - title: The title of the alert
    ///   - message: The message to display
    ///   - retryAction: Closure to execute when retry is tapped
    ///   - closeAction: Closure to execute when close is tapped
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
    /// Returns a localized error message for the network error type.
    ///
    /// - Returns: A localized string describing the error
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
    /// Returns a localized error message for the response error.
    ///
    /// This method:
    /// - Handles network errors by delegating to NetworkErrorType
    /// - Returns a custom message if provided
    /// - Falls back to a generic error message if no custom message exists
    ///
    /// - Returns: A localized string describing the error
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
