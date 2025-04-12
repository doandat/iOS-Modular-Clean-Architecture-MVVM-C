//
//  TxShimmerModifier.swift
//  TxDesignSystem
//
//  Created by doandat on 11/4/25.
//

import TxFoundation
import SwiftUI

extension View {
    public func shimmer(isLoading: Bool, row: Int = 6) -> some View {
        modifier(TxShimmerModifier(isLoadingShimmer: isLoading, row: row))
    }
}

struct TxShimmerModifier: ViewModifier {
    var isLoadingShimmer: Bool
    var row: Int

    func body(content: Content) -> some View {
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

struct TxShimmerRow: View {
    var row: Int

    var body: some View {
        loadInitialDataView
            .padding(.horizontal, 12)
            .frame(height: heightRow)
    }

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

    private var color: Color {
        Color.black.opacity(0.2)
    }

    private var cornerRadius: CGFloat {
        4
    }

    private var heightRow: CGFloat {
        92
    }
}

#Preview {
    TxShimmerRow(row: 5)
}
