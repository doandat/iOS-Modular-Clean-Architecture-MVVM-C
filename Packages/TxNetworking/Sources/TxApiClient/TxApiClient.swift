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

public typealias NetworkErrorAlertHandler = (
    _ error: TxResponseError.NetworkErrorType,
    _ onAlertNetworkAction: @escaping (TxResponseError.AlertActionNetworkError) -> Void
) -> Void
public typealias CommonErrorAlertHandler = (
    _ error: TxResponseError,
    _ onAlertNetworkAction: @escaping (TxResponseError.AlertActionNetworkError) -> Void
) -> Void
public typealias NetworkActionHandler = (
    _ action: TxResponseError.AlertActionNetworkError,
    _ error: TxResponseError
) -> Void


public protocol TxApiClientProtocol {
    @MainActor
    var onLoading: (Bool) async -> Void { set get }
    @MainActor
    var alertErrorNetworkConnection: NetworkErrorAlertHandler { set get }
    @MainActor
    var alertErrorNetworkCommon: CommonErrorAlertHandler { set get }
    @MainActor
    var onAlertNetworkAction: NetworkActionHandler { set get }
    
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

public final class TxApiClient: TxApiClientProtocol {
    public init() {}

    @MainActor
    public var onLoading: (Bool) async -> Void = { _ in }
    @MainActor
    public var alertErrorNetworkConnection: NetworkErrorAlertHandler = { _, _ in }
    @MainActor
    public var alertErrorNetworkCommon: CommonErrorAlertHandler = { _, _ in }
    @MainActor
    public var onAlertNetworkAction: NetworkActionHandler = { _, _ in }

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
