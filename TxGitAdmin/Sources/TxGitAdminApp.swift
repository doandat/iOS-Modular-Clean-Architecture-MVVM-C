//
//  TxGitAdminApp.swift
//  TxGitAdmin
//
//  Created by doandat on 9/4/25.
//

import SwiftUI
import Resolver
import TxDesignSystem
import TxTheme
import TxFont
import TxLocalization
import TxDeeplink
import TxGithubProfiles

@main
struct TxGitAdminApp: App {
    init() {
        TxDesignSystem.Fonts.registerFonts()
        setupDI()
        initRootView()
    }
    
    var body: some Scene {
        WindowGroup {
            TxNavigationContainerView(rootView: AnyView(DeepLinksService.shared.getRootView()))
                .ignoresSafeArea()
                .environmentObject(Resolver.resolve(TxThemeManager.self))
                .environmentObject(Resolver.resolve(L10n.self))
                
        }
    }
}

extension TxGitAdminApp {
    private func setupDI() {
        Resolver.register { TxThemeManager() }.scope(ResolverScope.application)
        Resolver.register { L10n() }.scope(ResolverScope.application)
        TxGithubProfiles.Configuration().register()
    }
    
    private func initRootView() {
        let deepLinkType = TxDeeplinkPath.GithubProfile.list
        guard let deeplink = TxDeeplinkHelper.makeDeeplink(type: deepLinkType) else { return }
        Task { @MainActor in
            DeepLinksService.shared.handleURL(deeplink)
        }

    }
}
