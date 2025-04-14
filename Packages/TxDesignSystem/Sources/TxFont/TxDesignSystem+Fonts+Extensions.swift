//
//  TxDesignSystem+Fonts+Extensions.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import TxDesignSystem

/// Extension providing predefined typography styles.
///
/// This extension provides:
/// - Heading styles (H1-H4)
/// - Title styles
/// - Base text styles
/// - Small text styles
/// - Caption styles
/// - Subtitle styles
extension TxDesignSystem.Fonts {
    /// Collection of predefined typography styles.
    public struct Typography {
        private typealias FontName = TxDesignSystem.Fonts.FontName

        // MARK: - H1 Styles
        /// H1 heading with bold weight.
        public static func h1Bold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.bold,
                fontSize: 32,
                lineHeight: 40,
                letterSpacing: -0.64,
                align: align
            )
        }

        /// H1 heading with medium weight.
        public static func h1Medium(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.medium,
                fontSize: 32,
                lineHeight: 40,
                letterSpacing: -1.28,
                align: align
            )
        }

        // MARK: - H2 Styles
        /// H2 heading with bold weight.
        public static func h2Bold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.bold,
                fontSize: 26,
                lineHeight: 36,
                letterSpacing: -0.52,
                align: align
            )
        }

        /// H2 heading with semi-bold weight.
        public static func h2Semibold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.semibold,
                fontSize: 26,
                lineHeight: 36,
                letterSpacing: -1.04,
                align: align
            )
        }

        /// H2 heading with medium weight.
        public static func h2Medium(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.medium,
                fontSize: 26,
                lineHeight: 36,
                letterSpacing: -1.04,
                align: align
            )
        }

        // MARK: - H3 Styles
        /// H3 heading with bold weight.
        public static func h3Bold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.bold,
                fontSize: 22,
                lineHeight: 32,
                letterSpacing: -0.66,
                align: align
            )
        }

        /// H3 heading with semi-bold weight.
        public static func h3Semibold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.semibold,
                fontSize: 22,
                lineHeight: 32,
                letterSpacing: -0.88,
                align: align
            )
        }

        /// H3 heading with medium weight.
        public static func h3Medium(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.medium,
                fontSize: 22,
                lineHeight: 32,
                letterSpacing: -0.88,
                align: align
            )
        }

        // MARK: - H4 Styles
        /// H4 heading with bold weight.
        public static func h4Bold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.bold,
                fontSize: 20,
                lineHeight: 28,
                letterSpacing: -0.3,
                align: align
            )
        }

        /// H4 heading with semi-bold weight.
        public static func h4SemiBold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.semibold,
                fontSize: 20,
                lineHeight: 28,
                letterSpacing: -0.5,
                align: align
            )
        }

        /// H4 heading with medium weight.
        public static func h4Medium(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.medium,
                fontSize: 20,
                lineHeight: 28,
                letterSpacing: -0.6,
                align: align
            )
        }

        // MARK: - Title Styles
        /// Title text with bold weight.
        public static func titleBold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.bold,
                fontSize: 18,
                lineHeight: 24,
                letterSpacing: -0.27,
                align: align
            )
        }

        /// Title text with semi-bold weight.
        public static func titleSemibold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.semibold,
                fontSize: 18,
                lineHeight: 24,
                letterSpacing: -0.27,
                align: align
            )
        }

        /// Title text with medium weight.
        public static func titleMedium(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.medium,
                fontSize: 18,
                lineHeight: 24,
                letterSpacing: -0.27,
                align: align
            )
        }

        // MARK: - Base Styles
        /// Base text with semi-bold weight.
        public static func baseSemibold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.semibold,
                fontSize: 16,
                lineHeight: 24,
                letterSpacing: -0.32,
                align: align
            )
        }

        /// Base text with medium weight.
        public static func baseMedium(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.medium,
                fontSize: 16,
                lineHeight: 24,
                letterSpacing: -0.32,
                align: align
            )
        }

        /// Base text with regular weight.
        public static func baseRegular(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.regular,
                fontSize: 16,
                lineHeight: 24,
                letterSpacing: -0.4,
                align: align
            )
        }

        // MARK: - Small Styles
        /// Small text with semi-bold weight.
        public static func smallSemibold(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.semibold,
                fontSize: 14,
                lineHeight: 20,
                letterSpacing: -0.28,
                align: align
            )
        }

        /// Small text with medium weight.
        public static func smallMedium(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.medium,
                fontSize: 14,
                lineHeight: 20,
                letterSpacing: -0.28,
                align: align
            )
        }

        /// Small text with regular weight.
        public static func smallRegular(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.regular,
                fontSize: 14,
                lineHeight: 20,
                letterSpacing: -0.42,
                align: align
            )
        }

        // MARK: - Caption Styles
        /// Caption text with medium weight.
        public static func captionMedium(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.medium,
                fontSize: 12,
                lineHeight: 16,
                letterSpacing: -0.36,
                align: align
            )
        }

        /// Caption text with regular weight.
        public static func captionRegular(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.regular,
                fontSize: 12,
                lineHeight: 16,
                letterSpacing: -0.36,
                align: align
            )
        }

        // MARK: - Subtitle Style
        /// Subtitle text with medium weight.
        public static func subtitleMedium(align: TextAlignment = .leading) -> TypographyStyle {
            return TypographyStyle(
                fontName: FontName.medium,
                fontSize: 18,
                lineHeight: 20,
                letterSpacing: -0.28,
                align: align
            )
        }
    }
}
