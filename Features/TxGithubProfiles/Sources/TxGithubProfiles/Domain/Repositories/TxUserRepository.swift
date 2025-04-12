import Foundation
import Combine

public protocol TxUserRepository {
    func getUsers(page: Int, pageSize: Int) async throws -> [TxGithubUser]
    func getUserDetail(userId: String) async throws -> TxGithubUser
}
