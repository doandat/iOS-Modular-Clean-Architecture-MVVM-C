import Foundation
import Combine
@testable import TxGithubProfiles

class TxMockUserRepository: TxUserRepository {
    var users: [TxGithubUser] = []
    var userDetails: [String: TxGithubUser] = [:]
    var error: Error?
    var getUsersCallCount = 0
    var getUserDetailCallCount = 0
    @MainActor
    func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUser] {
        getUsersCallCount += 1
        if let error = error {
            throw error
        }
        return users
    }
    
    @MainActor
    func getUserDetail(loginUsername: String) async throws -> TxGithubUser {
        getUserDetailCallCount += 1
        if let error = error {
            throw error
        }
        guard let user = userDetails[loginUsername] else {
            throw NSError(domain: "TxUserRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        return user
    }
} 
