//
//  TxBoxBorderModifier.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import TxTheme

/// A view modifier that adds a box border to a view.
///
/// This modifier provides:
/// - Border styling
/// - Corner radius
/// - Background color
public struct TxBoxBorderModifier: ViewModifier {
    @EnvironmentObject var themeManager: TxThemeManager
    var borderInput: BoxBorderInput

    /// Creates a new box border modifier.
    ///
    /// - Parameters:
    ///   - borderInput: The border input
    public init(borderInput: BoxBorderInput = .default) {
        self.borderInput = borderInput
    }

    /// Applies the modifier to a view.
    ///
    /// - Parameter content: The content view
    /// - Returns: The modified view
    public func body(content: Content) -> some View {
        content
            .padding(TxSize.size400.rawValue)
            .background(
                RoundedRectangle(cornerRadius: borderInput.cornerRadius)
                    .fill(themeManager.selectedColor.backgroundSecondary)
                    .shadow(
                        color: borderInput.color,
                        radius: borderInput.cornerRadius,
                        x: borderInput.x,
                        y: borderInput.y
                    )
            )
            .frame(maxWidth: .infinity)
    }
}

// swiftlint:disable identifier_name
extension TxBoxBorderModifier {
    /// The input for the box border
    public struct BoxBorderInput: Sendable {
        /// The corner radius
        let cornerRadius: Double
        /// The color of the border
        let color: SwiftUI.Color
        /// The shadow radius
        let shadowRadius: CGFloat
        /// The x position of the shadow
        let x: CGFloat
        /// The y position of the shadow
        let y: CGFloat

        /// Creates a new box border input.
        ///
        /// - Parameters:
        ///   - cornerRadius: The corner radius
        ///   - color: The border color
        ///   - shadowRadius: The shadow radius
        ///   - x: The x position of the shadow
        ///   - y: The y position of the shadow
        public init(
            cornerRadius: Double,
            color: SwiftUI.Color,
            shadowRadius: CGFloat,
            x: CGFloat,
            y: CGFloat
        ) {
            self.cornerRadius = cornerRadius
            self.color = color
            self.shadowRadius = shadowRadius
            self.x = x
            self.y = y
        }

        /// The default box border input
        public static let `default`: BoxBorderInput = .init(
            cornerRadius: TxSize.size300.rawValue,
            color: SwiftUI.Color(r: 29, g: 41, b: 57, a: 0.15),
            shadowRadius: 4,
            x: 0,
            y: 1
        )
    }
}

// swiftlint:enable identifier_name
