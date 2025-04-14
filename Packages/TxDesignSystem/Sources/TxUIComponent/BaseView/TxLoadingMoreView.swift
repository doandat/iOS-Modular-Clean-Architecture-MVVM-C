//
//  TxLoadingMoreView.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI

/// A view that displays a loading indicator for pagination.
///
/// This view provides:
/// - Loading indicator for infinite scroll
/// - Customizable appearance
/// - Progress view integration
public struct TxLoadingMoreView: View {
    @State private var animate = false
    let message: String

    public init(message: String) {
        self.message = message
    }

    /// The body of the loading view.
    ///
    /// This view:
    /// - Displays a progress indicator
    /// - Centers the indicator horizontally
    /// - Applies padding
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
