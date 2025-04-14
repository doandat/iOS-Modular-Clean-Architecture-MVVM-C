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

/// A Swift package that provides functionality for displaying and managing GitHub user profiles.
///
/// This package follows Clean Architecture principles and provides a modular way to display GitHub user profiles,
/// including user lists and detailed user information.
public struct TxGithubProfiles {}

extension TxGithubProfiles {
    /// Configuration structure for setting up the GitHub Profiles module.
    ///
    /// This structure handles the dependency injection setup using Resolver,
    /// registering all necessary services, repositories, and use cases.
    public struct Configuration {
        /// Creates a new configuration instance.
        public init() {}

        /// Registers all dependencies required by the GitHub Profiles module.
        ///
        /// This method sets up:
        /// - User manager service for API communication
        /// - User repository for data management
        /// - Use cases for business logic
        ///
        /// - Note: This method must be called before using any functionality from the module.
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
