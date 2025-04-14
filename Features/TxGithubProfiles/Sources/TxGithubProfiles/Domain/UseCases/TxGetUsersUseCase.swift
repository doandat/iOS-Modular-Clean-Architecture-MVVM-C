import Foundation
import Combine
import Resolver

public protocol TxGetUsersUseCase {
    @MainActor
    func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUser]
}

public class TxGetUsersUseCaseImpl: TxGetUsersUseCase {
    @Injected private var repository: TxUserRepository

    public init() {}

    public func getUsers(since: Int, pageSize: Int) async throws -> [TxGithubUser] {
        return try await repository.getUsers(since: since, pageSize: pageSize)
    }
}
