//
//  TxDesignSystem+Font.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import UIKit
import TxDesignSystem

/// Extension providing font system definitions.
///
/// This extension provides:
/// - Font name definitions
/// - Typography styles
/// - Font registration
extension TxDesignSystem.Fonts {
    /// Available font weights.
    ///
    /// This enum defines:
    /// - Regular weight
    /// - Medium weight
    /// - Semi-bold weight
    /// - Bold weight
    public enum FontName: String, CaseIterable {
        case regular = "Inter-Regular"
        case medium = "Inter-Medium"
        case semibold = "Inter-SemiBold"
        case bold = "Inter-Bold"
    }

    /// Typography style definition.
    ///
    /// This struct provides:
    /// - Font name
    /// - Font size
    /// - Line height
    /// - Letter spacing
    /// - Text alignment
    public struct TypographyStyle {
        /// The font name to use
        public let fontName: FontName
        /// The font size in points
        public let fontSize: CGFloat
        /// The line height in points
        public let lineHeight: CGFloat
        /// The letter spacing in points
        public let letterSpacing: CGFloat
        /// The text alignment
        public let align: TextAlignment

        /// SwiftUI font instance
        public var font: SwiftUI.Font {
            return SwiftUI.Font.custom(fontName.rawValue, size: fontSize)
        }

        /// UIKit font instance
        public var uiFont: UIFont {
            return UIFont(name: fontName.rawValue, size: fontSize)!
        }

        /// Calculated line spacing
        public var spacing: CGFloat {
            return lineHeight - roundToPlaces(uiFont.lineHeight, places: 2)
        }

        /// Vertical padding for text alignment
        public var paddingVertical: CGFloat {
            return (lineHeight - roundToPlaces(uiFont.lineHeight, places: 2)) / 2
        }
        
        private func roundToPlaces(_ value: Double, places: Int) -> Double {
            let multiplier = pow(10.0, Double(places))
            return (value * multiplier).rounded() / multiplier
        }
    }

    /// Applies typography style to a view.
    ///
    /// - Parameters:
    ///   - typography: The typography style to apply
    ///   - forAttributed: Whether the text is attributed
    @MainActor
    public static func style(_ typography: TypographyStyle, forAttributed: Bool = false) -> some ViewModifier {
        return FontModifier(typography: typography, forAttributed: forAttributed)
    }

    /// View modifier for applying typography styles.
    public struct FontModifier: ViewModifier {
        /// The typography style to apply
        public let typography: TypographyStyle
        /// Whether the text is attributed
        public let forAttributed: Bool

        public func body(content: Content) -> some View {
            if #available(iOS 16.0, *) {
                if forAttributed {
                    content
                        .lineSpacing(typography.spacing)
                        .padding(.vertical, typography.paddingVertical)
                        .tracking(typography.letterSpacing)
                        .multilineTextAlignment(typography.align)
                } else {
                    content
                        .font(typography.font)
                        .lineSpacing(typography.spacing)
                        .padding(.vertical, typography.paddingVertical)
                        .tracking(typography.letterSpacing)
                        .multilineTextAlignment(typography.align)
                }
            } else {
                if forAttributed {
                    content
                        .lineSpacing(typography.spacing)
                        .padding(.vertical, typography.paddingVertical)
                        .multilineTextAlignment(typography.align)
                } else {
                    content
                        .font(typography.font)
                        .lineSpacing(typography.spacing)
                        .padding(.vertical, typography.paddingVertical)
                        .multilineTextAlignment(typography.align)
                }
            }
        }
    }
}

extension TxDesignSystem.Fonts {
    /// Registers all available fonts in the system.
    public static func registerFonts() {
        TxFont.FontName.allCases.forEach {
            registerFont(bundle: Bundle.txFont,
                         fontName: $0.rawValue,
                         fontExtension: "ttf")
        }
    }

    /// Registers a single font file.
    ///
    /// - Parameters:
    ///   - bundle: The bundle containing the font
    ///   - fontName: The name of the font
    ///   - fontExtension: The font file extension
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
