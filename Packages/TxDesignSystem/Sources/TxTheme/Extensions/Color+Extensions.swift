//
//  Color+Extensions.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
// swiftlint:disable identifier_name

/// Extension providing color initialization from hex strings.
///
/// This extension provides:
/// - Hex string to Color conversion
/// - Support for different hex formats
/// - Alpha channel support
extension Color {
    /// Creates a color from a hex string.
    ///
    /// Supports formats:
    /// - 3 digits (RGB)
    /// - 6 digits (RGB)
    /// - 8 digits (ARGB)
    ///
    /// - Parameter hex: The hex string to convert
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

/// Extension providing color initialization from RGB values.
extension Color {
    /// Creates a color from RGB values.
    ///
    /// - Parameters:
    ///   - r: Red component (0-255)
    ///   - g: Green component (0-255)
    ///   - b: Blue component (0-255)
    ///   - a: Alpha component (0-1)
    public init(r: Double, g: Double, b: Double, a: Double) {
        self.init(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0,
            opacity: a
        )
    }
}

// swiftlint:enable identifier_name
