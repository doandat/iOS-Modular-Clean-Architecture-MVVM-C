import Foundation
import Combine
@testable import TxGithubProfiles

class TxMockGithubProfileNavigation: TxGithubProfileNavigation {
    
    var didShowAlert = false
    var didRouteToUserList = false
    var didRouteToUserDetail = false
    var userDetailLoginUsername: String?
    var didGoBack = false
    var didRetryAction = false
    func showAlert(
        title: String,
        message: String,
        retryAction: @escaping () -> Void,
        closeAction: @escaping () -> Void
    ) {
        didShowAlert = true
        if didRetryAction {
            closeAction()
        } else {
            retryAction()
            didRetryAction = true
        }
        
    }
    
    func routeToUserlist() {
        didRouteToUserList = true
    }
    
    func routeToUserDetail(loginUsername: String) {
        didRouteToUserDetail = true
        userDetailLoginUsername = loginUsername
    }
    
    func goBack() {
        didGoBack = true
    }
} 
