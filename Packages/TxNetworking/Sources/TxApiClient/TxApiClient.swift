//
//  TxAPIClient.swift
//  TxNetworking
//
//  Created by doandat on 12/4/25.
//

import Foundation
import Moya
import TxLogger
import TxNetworkModels

/// Type alias for handling network error alerts.
///
/// - Parameters:
///   - error: The network error type
///   - onAlertNetworkAction: Closure to handle the alert action
public typealias NetworkErrorAlertHandler = (
    _ error: TxResponseError.NetworkErrorType,
    _ onAlertNetworkAction: @escaping (TxResponseError.AlertActionNetworkError) -> Void
) -> Void

/// Type alias for handling common error alerts.
///
/// - Parameters:
///   - error: The response error
///   - onAlertNetworkAction: Closure to handle the alert action
public typealias CommonErrorAlertHandler = (
    _ error: TxResponseError,
    _ onAlertNetworkAction: @escaping (TxResponseError.AlertActionNetworkError) -> Void
) -> Void

/// Type alias for handling network actions.
///
/// - Parameters:
///   - action: The alert action to perform
///   - error: The associated error
public typealias NetworkActionHandler = (
    _ action: TxResponseError.AlertActionNetworkError,
    _ error: TxResponseError
) -> Void

/// Protocol defining the interface for API client functionality.
///
/// This protocol provides methods and properties for:
/// - Managing loading states
/// - Handling network errors
/// - Performing API requests
public protocol TxApiClientProtocol {
    /// Closure to handle loading state changes.
    @MainActor
    var onLoading: (Bool) async -> Void { set get }
    
    /// Handler for network connection errors.
    @MainActor
    var alertErrorNetworkConnection: NetworkErrorAlertHandler { set get }
    
    /// Handler for common network errors.
    @MainActor
    var alertErrorNetworkCommon: CommonErrorAlertHandler { set get }
    
    /// Handler for network alert actions.
    @MainActor
    var onAlertNetworkAction: NetworkActionHandler { set get }
    
    /// Performs an API request with error handling and loading state management.
    ///
    /// - Parameters:
    ///   - action: The async action to perform
    ///   - loading: Optional loading state handler
    ///   - alertErrorNetworkConnection: Optional network error handler
    ///   - alertErrorNetworkCommon: Optional common error handler
    ///   - onAlertNetworkAction: Optional action handler
    /// - Returns: The result of the action if successful
    @MainActor
    @discardableResult
    func performRequest<R: Sendable>(
        action: () async throws -> R,
        loading: ((Bool) async -> Void)?,
        alertErrorNetworkConnection: NetworkErrorAlertHandler?,
        alertErrorNetworkCommon: CommonErrorAlertHandler?,
        onAlertNetworkAction: NetworkActionHandler?
    ) async throws -> R?
}

/// Implementation of the API client protocol.
///
/// This class provides concrete implementation for:
/// - Managing loading states
/// - Handling network errors
/// - Performing API requests with proper error handling
public final class TxApiClient: TxApiClientProtocol {
    /// Creates a new API client instance.
    public init() {}

    /// Default loading state handler.
    @MainActor
    public var onLoading: (Bool) async -> Void = { _ in }
    
    /// Default network error handler.
    @MainActor
    public var alertErrorNetworkConnection: NetworkErrorAlertHandler = { _, _ in }
    
    /// Default common error handler.
    @MainActor
    public var alertErrorNetworkCommon: CommonErrorAlertHandler = { _, _ in }
    
    /// Default action handler.
    @MainActor
    public var onAlertNetworkAction: NetworkActionHandler = { _, _ in }

    /// Performs an API request with error handling and loading state management.
    ///
    /// This method:
    /// - Manages loading states
    /// - Handles network errors
    /// - Logs errors in debug mode
    /// - Provides error callbacks
    ///
    /// - Parameters:
    ///   - action: The async action to perform
    ///   - loading: Optional loading state handler
    ///   - alertErrorNetworkConnection: Optional network error handler
    ///   - alertErrorNetworkCommon: Optional common error handler
    ///   - onAlertNetworkAction: Optional action handler
    /// - Returns: The result of the action if successful
    @MainActor
    @discardableResult
    public func performRequest<R: Sendable>(
        action: () async throws -> R,
        loading: ((Bool) async -> Void)? = nil,
        alertErrorNetworkConnection: NetworkErrorAlertHandler? = nil,
        alertErrorNetworkCommon: CommonErrorAlertHandler? = nil,
        onAlertNetworkAction: NetworkActionHandler? = nil
    ) async throws -> R? {
        let loading = loading ?? onLoading
        let alertErrorNetworkConnection = alertErrorNetworkConnection ?? self.alertErrorNetworkConnection
        let alertErrorNetworkCommon = alertErrorNetworkCommon ?? self.alertErrorNetworkCommon
        let onAlertNetworkAction = onAlertNetworkAction ?? self.onAlertNetworkAction

        do {
            await loading(true)
            let result = try await action()
            await loading(false)

            return result
        } catch let error as TxResponseError {
#if DEBUG
            TxLogger().error("ApiClient response error:")
            TxLogger().error(error)
#endif
            await loading(false)
            switch error.errorType {
            case let .network(type):
                alertErrorNetworkConnection(type) { action in
                    onAlertNetworkAction(action, error)
                }
            default:
                alertErrorNetworkCommon(error) { action in
                    onAlertNetworkAction(action, error)
                }
            }
            return nil
        } catch {
#if DEBUG
            TxLogger().error("ApiClient unexpected error:")
            TxLogger().error(error)
#endif
            await loading(false)
            throw error
        }
    }
}
