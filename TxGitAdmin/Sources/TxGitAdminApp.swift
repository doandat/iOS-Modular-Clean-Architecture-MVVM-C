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

/// The main application structure for TxGitAdmin.
///
/// This is the entry point of the application and handles:
/// - Initial setup and configuration
/// - Dependency injection
/// - Network configuration
/// - Debug setup
/// - Root view presentation
@main
struct TxGitAdminApp: App {
    /// Initializes the application and sets up required configurations.
    ///
    /// This initializer:
    /// - Registers custom fonts
    /// - Sets up dependency injection
    /// - Configures network settings
    /// - Initializes debug tools
    init() {
        TxDesignSystem.Fonts.registerFonts()
        setupDI()
        setupNetwork()
        setupDebug()
    }
    
    /// The main scene of the application.
    ///
    /// This scene:
    /// - Creates the main window group
    /// - Sets up the root view with deep linking support
    /// - Applies theme and localization environment objects
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

/// The main content view of the application.
///
/// This view provides:
/// - Theme management
/// - System appearance handling
/// - Root view presentation
struct ContentView: View {
    /// The current color scheme of the system
    @Environment(\.colorScheme) var colorScheme
    /// The current dark mode state
    @State private var isDarkMode: Bool = false

    /// The body of the content view.
    ///
    /// This view:
    /// - Sets up the navigation container
    /// - Handles theme changes
    /// - Applies environment objects
    var body: some View {
        TxNavigationContainerView(rootView: AnyView(TxDeepLinksService.getRootView()))
            .ignoresSafeArea()
            .environmentObject(Resolver.resolve(TxThemeManager.self))
            .environmentObject(Resolver.resolve(L10n.self))
            .onAppear() {
                // Initialize theme state
                isDarkMode = colorScheme == .dark
                let themeManager = Resolver.resolve(TxThemeManager.self)
                themeManager.switchSystemTheme(isDarkMode: isDarkMode)
            }
            .onChange(of: colorScheme) { newScheme in
                // Handle system theme changes
                isDarkMode = newScheme == .dark
                let themeManager = Resolver.resolve(TxThemeManager.self)
                themeManager.switchSystemTheme(isDarkMode: isDarkMode)
            }
    }
}
