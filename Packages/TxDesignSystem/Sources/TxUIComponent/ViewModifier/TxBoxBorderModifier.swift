import SwiftUI
import TxTheme

public struct TxBoxBorderModifier: ViewModifier {
    @EnvironmentObject var themeManager: TxThemeManager
    var borderInput: BoxBorderInput

    public init(borderInput: BoxBorderInput = .default) {
        self.borderInput = borderInput
    }

    public func body(content: Content) -> some View {
        content
            .padding(TxSize.size400.rawValue)
            .background(
                RoundedRectangle(cornerRadius: borderInput.cornerRadius)
                    .fill(themeManager.selectedColor.backgroundWhite)
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
    public struct BoxBorderInput: Sendable {
        let cornerRadius: Double
        let color: SwiftUI.Color
        let shadowRadius: CGFloat
        let x: CGFloat
        let y: CGFloat

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
