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
import TxApiClient
import TxLogger
import TxUIComponent

@main
struct TxGitAdminApp: App {
    init() {
        TxDesignSystem.Fonts.registerFonts()
        setupDI()
        setupNetwork()
        setupDebug()
    }
    
    var body: some Scene {
        WindowGroup {
            TxNavigationContainerView(rootView: AnyView(TxDeepLinksService.getRootView()))
                .ignoresSafeArea()
                .environmentObject(Resolver.resolve(TxThemeManager.self))
                .environmentObject(Resolver.resolve(L10n.self))
                
        }
    }
}
