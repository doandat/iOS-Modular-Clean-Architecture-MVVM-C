import Foundation
import Combine
@testable import TxGithubProfiles
import TxGithubUserManagerInterface

class TxMockGithubUserManagerInterface: TxGithubUserManagerInterface {
    var users: [TxGithubUserDTO] = []
    var userDetails: [String: TxGithubUserDTO] = [:]
    var error: Error?
    
    func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUserDTO] {
        if let error = error {
            throw error
        }
        return users
    }
    
    func getUserDetail(loginUsername: String) async throws -> TxGithubUserDTO {
        if let error = error {
            throw error
        }
        guard let user = userDetails[loginUsername] else {
            throw NSError(domain: "TxUserRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        return user
    }
} 
