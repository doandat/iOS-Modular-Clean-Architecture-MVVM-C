//
//  TxShimmerModifier.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import TxFoundation
import SwiftUI

/// Extension for adding shimmer effect to views.
extension View {
    /// Adds a shimmer effect to a view.
    ///
    /// - Parameters:
    ///   - isLoading: Whether to show the shimmer effect
    ///   - row: The number of shimmer rows
    /// - Returns: A view with shimmer effect
    public func shimmer(isLoading: Bool, row: Int = 6) -> some View {
        modifier(TxShimmerModifier(isLoadingShimmer: isLoading, row: row))
    }
}

/// A view modifier that adds a shimmering effect to a view.
///
/// This modifier provides:
/// - Shimmering animation
/// - Gradient overlay
/// - Customizable appearance
public struct TxShimmerModifier: ViewModifier {
    /// Whether the shimmer effect is active
    var isLoadingShimmer: Bool
    /// The number of shimmer rows
    var row: Int

    /// Applies the modifier to a view.
    ///
    /// - Parameter content: The content view
    /// - Returns: The modified view
    public func body(content: Content) -> some View {
        ZStack {
            content
            if isLoadingShimmer {
                VStack {
                    VStack {
                        TxShimmerRow(row: row)
                    }
                    .background(.white)
                    .cornerRadius(12)
                    .padding(16)

                    Spacer()
                }
            }
        }
    }
}

/// A row of shimmering content.
struct TxShimmerRow: View {
    /// The number of shimmer rows
    var row: Int

    /// The body of the shimmer row.
    var body: some View {
        loadInitialDataView
            .padding(.horizontal, 12)
            .frame(height: heightRow)
    }

    /// The shimmer content view.
    private var loadInitialDataView: some View {
        ForEach(0 ..< row, id: \.self) { index in
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Rectangle()
                            .fill(color)
                            .frame(width: 200)
                            .frame(height: 24)
                            .cornerRadius(cornerRadius)
                            .redacted(reason: .placeholder)
                        Spacer()
                    }
                    Rectangle()
                        .fill(color)
                        .frame(height: 24)
                        .cornerRadius(cornerRadius)
                        .redacted(reason: .placeholder)
                }
                .shimmering()
                .padding(.top, 15)

                Spacer()

                if index < row - 1 {
                    Divider()
                }
            }
        }
    }

    /// The shimmer color
    private var color: Color {
        Color.black.opacity(0.2)
    }

    /// The corner radius
    private var cornerRadius: CGFloat {
        4
    }

    /// The row height
    private var heightRow: CGFloat {
        92
    }
}

#Preview {
    TxShimmerRow(row: 5)
}
