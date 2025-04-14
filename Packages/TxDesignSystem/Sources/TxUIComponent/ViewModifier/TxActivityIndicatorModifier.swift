//
//  TxActivityIndicatorModifier.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI

/// Loading Indicator View
struct TxLoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .scaleEffect(1.5)
            .padding(30)
            .background(Color.black.opacity(0.7))
            .cornerRadius(15)
    }
}

/// Loading Overlay with Background
struct TxLoadingOverlay<Content: View>: View {
    @Binding var isShowing: Bool
    let content: Content

    init(isShowing: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isShowing = isShowing
        self.content = content()
    }

    var body: some View {
        ZStack {
            content
                .disabled(isShowing)
                .blur(radius: isShowing ? 2 : 0)

            if isShowing {
                GeometryReader { geometry in
                    TxLoadingView()
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .transition(.scale)
                        .animation(.easeInOut, value: isShowing)
                }
            }
        }
    }
}

/// A view modifier that adds an activity indicator overlay.
///
/// This modifier provides:
/// - Loading indicator overlay
/// - Customizable appearance
/// - Background dimming
public struct TxActivityIndicatorModifier: ViewModifier {
    /// Whether the activity indicator is shown
    let isPresented: Bool
    /// The color of the activity indicator
    let color: Color
    /// The background color
    let backgroundColor: Color

    /// Creates a new activity indicator modifier.
    ///
    /// - Parameters:
    ///   - isPresented: Whether to show the indicator
    ///   - color: The color of the indicator
    ///   - backgroundColor: The background color
    public init(
        isPresented: Bool,
        color: Color = .primary,
        backgroundColor: Color = Color.black.opacity(0.3)
    ) {
        self.isPresented = isPresented
        self.color = color
        self.backgroundColor = backgroundColor
    }

    /// Applies the modifier to a view.
    ///
    /// - Parameter content: The content view
    /// - Returns: The modified view
    public func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isPresented)
                .blur(radius: isPresented ? 3 : 0)

            if isPresented {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: color))
                    .scaleEffect(1.5)
            }
        }
    }
}

// MARK: - View Modifier
public extension View {
    func activityIndicator(isShowing: Binding<Bool>) -> some View {
        TxLoadingOverlay(isShowing: isShowing) {
            self
        }
    }
}
