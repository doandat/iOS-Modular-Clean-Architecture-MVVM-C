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
            let settingsManagerService: TxGithubUserManagerService = {
                return TxGithubUserManagerService(
                    baseURL: TxEnvironmentValues.apiHost
                )
            }()

            let repository = TxUserRepositoryImpl(remoteDataSource: settingsManagerService)
            Resolver.register { repository as TxUserRepository }

            let getUsersUseCase = TxGetUsersUseCaseImpl()
            let getUserDetailUseCase = TxGetUserDetailUseCaseImpl()

            Resolver.register { getUsersUseCase as TxGetUsersUseCase }
            Resolver.register { getUserDetailUseCase as TxGetUserDetailUseCase }
        }
    }
}
