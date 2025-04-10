//
//  ContentView.swift
//  TxGitAdmin
//
//  Created by doandat on 9/4/25.
//

import SwiftUI
import TxDeeplink
import TxLogger

struct ContentView: View {
    init() {
        
    }
    var body: some View {
        VStack {
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
