//
//  ContentView.swift
//  TxDesignSystemExample
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import TxDesignSystem
import TxUIComponent
import TxTheme

struct ContentView: View {
    var body: some View {
        VStack {
            TxDesignSystem.UIComponent.TxNavigationView(title: "Home")
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
