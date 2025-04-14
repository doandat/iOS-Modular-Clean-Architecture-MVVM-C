import Foundation
import Combine
import Resolver

public protocol TxGetUserDetailUseCase {
    @MainActor
    func getUserDetail(loginUsername: String) async throws -> TxGithubUser
}

public class TxGetUserDetailUseCaseImpl: TxGetUserDetailUseCase {
    @Injected private var repository: TxUserRepository

    public init() {}

    @MainActor public func getUserDetail(loginUsername: String) async throws -> TxGithubUser {
        return try await repository.getUserDetail(loginUsername: loginUsername)
    }
}
