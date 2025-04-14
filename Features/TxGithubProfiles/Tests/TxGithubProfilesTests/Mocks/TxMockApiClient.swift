import Foundation
@testable import TxGithubProfiles
import TxApiClient
import Resolver
import TxNetworkModels

// Mock implementation
final class TxMockApiClient: TxApiClientProtocol {
    init() {}
    var onLoading: (Bool) async -> Void = { isLoading in
        
    }
    
    var alertErrorNetworkConnection: NetworkErrorAlertHandler = {networkError, onAlertNetworkAction in
        onAlertNetworkAction(.cancel)
    }
    
    var alertErrorNetworkCommon: CommonErrorAlertHandler = { networkError,
        onAlertNetworkAction in
        onAlertNetworkAction(.cancel)
        
    }
    
    var onAlertNetworkAction: NetworkActionHandler = { _,_  in
        
    }
    
    @discardableResult
    func performRequest<R: Sendable>(
        action: () async throws -> R,
        loading: ((Bool) async -> Void)?,
        alertErrorNetworkConnection: NetworkErrorAlertHandler?,
        alertErrorNetworkCommon: CommonErrorAlertHandler?,
        onAlertNetworkAction: NetworkActionHandler?
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
            await loading(false)
            throw error
        }
    }
}

// Extension cho Resolver để register mock
extension Resolver {
    static func registerMockApiClient(_ apiClient: TxApiClientProtocol) {
        Resolver.register { apiClient as TxApiClientProtocol }.implements(TxMockApiClient.self)
    }
} 
