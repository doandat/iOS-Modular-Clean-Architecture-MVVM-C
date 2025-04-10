//
//  TxDesignSystemExampleApp.swift
//  TxDesignSystemExample
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import TxTheme
import TxFont
import TxDesignSystem

@main
struct TxDesignSystemExampleApp: App {
    init() {
        TxDesignSystem.Fonts.registerFonts()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TxThemeManager())
        }
    }
}
