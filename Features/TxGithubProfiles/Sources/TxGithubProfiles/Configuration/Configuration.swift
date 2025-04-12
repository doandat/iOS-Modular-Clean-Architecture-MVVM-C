//
//  Configuration.swift
//  TxGithubProfiles
//
//  Created by doandat on 11/4/25.
//
import Foundation
import TxFoundation
import Resolver

public struct TxGithubProfiles {}

extension TxGithubProfiles {
    public struct Configuration {
        public init() {}

        @MainActor
        public func register() {
//            let settingsManagerService: SettingsManagerService = {
//                guard let config = Resolver.optional(MSBBackbaseConfiguration.self),
//                      let authPlugin = Resolver.optional(AccessTokenPlugin.self)
//                else {
//                    fatalError("Backbase Config not found")
//                }
//
//                let moyaProvider: MoyaProvider<SettingsManagerService.Target> = {
//                    .init(
//                        session: .init(configuration: config.securitySessionConfiguration),
//                        plugins: [authPlugin]
//                    )
//                }()
//
//                return SettingsManagerService(
//                    baseURL: config.baseURL,
//                    moyaProvider: moyaProvider
//                )
//            }()

//            let repository = TxUserRepositoryImpl(remoteDataSource: settingsManagerService)
            let repository = TxUserRepositoryImpl()
            Resolver.register { repository as TxUserRepository }

            let getUsersUseCase = TxGetUsersUseCaseImpl()
            let getUserDetailUseCase = TxGetUserDetailUseCaseImpl()

            Resolver.register { getUsersUseCase as TxGetUsersUseCase }
            Resolver.register { getUserDetailUseCase as TxGetUserDetailUseCase }
        }
    }
}
