//
//  Configuration.swift
//  TxGithubProfiles
//
//  Created by doandat on 11/4/25.
//
import Foundation
import Resolver
import TxFoundation
import TxGithubUserManagerService

public struct TxGithubProfiles {}

extension TxGithubProfiles {
    public struct Configuration {
        public init() {}

        @MainActor
        public func register() {
            let userManagerService: TxGithubUserManagerService = {
                return TxGithubUserManagerService(
                    baseURL: TxEnvironmentValues.apiHost
                )
            }()

            let repository = TxUserRepositoryImpl(remoteDataSource: userManagerService)
            Resolver.register { repository as TxUserRepository }

            let getUsersUseCase = TxGetUsersUseCaseImpl()
            let getUserDetailUseCase = TxGetUserDetailUseCaseImpl()

            Resolver.register { getUsersUseCase as TxGetUsersUseCase }
            Resolver.register { getUserDetailUseCase as TxGetUserDetailUseCase }
        }
    }
}
