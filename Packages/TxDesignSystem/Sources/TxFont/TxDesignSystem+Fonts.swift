//
//  TxDesignSystem+Font.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import UIKit
import TxDesignSystem

extension TxDesignSystem.Fonts {
    public enum FontName: String, CaseIterable {
        case regular = "Inter-Regular"
        case medium = "Inter-Medium"
        case semibold = "Inter-SemiBold"
        case bold = "Inter-Bold"
    }

    public struct TypographyStyle {
        public let fontName: FontName
        public let fontSize: CGFloat
        public let lineHeight: CGFloat
        public let letterSpacing: CGFloat
        public let align: TextAlignment

        public var font: SwiftUI.Font {
            return SwiftUI.Font.custom(fontName.rawValue, size: fontSize)
        }

        public var uiFont: UIFont {
            return UIFont(name: fontName.rawValue, size: fontSize)!
        }

        public var spacing: CGFloat {
            return lineHeight - roundToPlaces(uiFont.lineHeight, places: 2)
        }

        public var paddingVertical: CGFloat {
            return (lineHeight - roundToPlaces(uiFont.lineHeight, places: 2)) / 2
        }
        
        private func roundToPlaces(_ value: Double, places: Int) -> Double {
            let multiplier = pow(10.0, Double(places))
            return (value * multiplier).rounded() / multiplier
        }
    }

    @MainActor
    public static func style(_ typography: TypographyStyle, forAttributed: Bool = false) -> some ViewModifier {
        return FontModifier(typography: typography, forAttributed: forAttributed)
    }

    public struct FontModifier: ViewModifier {
        public let typography: TypographyStyle
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
    public static func registerFonts() {
        TxFont.FontName.allCases.forEach {
            registerFont(bundle: Bundle.txFont,
                         fontName: $0.rawValue,
                         fontExtension: "ttf")
        }
    }

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
