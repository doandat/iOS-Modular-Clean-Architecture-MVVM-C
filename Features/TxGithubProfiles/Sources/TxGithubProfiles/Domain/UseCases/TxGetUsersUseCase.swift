import Foundation
import Combine
import Resolver

public protocol TxGetUsersUseCase {
    func getUsers(page: Int, pageSize: Int) async throws -> [TxGithubUser]
}

public class TxGetUsersUseCaseImpl: TxGetUsersUseCase {
    @Injected private var repository: TxUserRepository

    public init() {}

    public func getUsers(page: Int, pageSize: Int) async throws -> [TxGithubUser] {
        return try await repository.getUsers(page: page, pageSize: pageSize)
    }
}
