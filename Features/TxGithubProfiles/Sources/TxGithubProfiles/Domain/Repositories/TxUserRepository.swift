import Foundation
import Combine

public protocol TxUserRepository {
    @MainActor
    func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUser]
    @MainActor
    func getUserDetail(loginUsername: String) async throws -> TxGithubUser
}
