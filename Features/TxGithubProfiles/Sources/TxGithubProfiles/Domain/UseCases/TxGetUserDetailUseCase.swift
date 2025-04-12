import Foundation
import Combine
import Resolver

public protocol TxGetUserDetailUseCase {
    func getUserDetail(userId: String) async throws -> TxGithubUser
}

public class TxGetUserDetailUseCaseImpl: TxGetUserDetailUseCase {
    @Injected private var repository: TxUserRepository

    public init() {}

    public func getUserDetail(userId: String) async throws -> TxGithubUser {
        return try await repository.getUserDetail(userId: userId)
    }
}
