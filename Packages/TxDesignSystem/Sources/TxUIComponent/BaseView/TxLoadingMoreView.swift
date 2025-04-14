//
//  TxLoadingMoreView.swift
//  TxDesignSystem
//
//  Created by doandat on 13/4/25.
//
import SwiftUI

public struct TxLoadingMoreView: View {
    @State private var animate = false
    let message: String

    public init(message: String) {
        self.message = message
    }

    public var body: some View {
        HStack {
            if animate {
                ProgressView(message)
                    .id(UUID())
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                EmptyView()
            }
        }
        .onAppear {
            animate = true
        }
        .onDisappear {
            animate = false
        }
    }
}
