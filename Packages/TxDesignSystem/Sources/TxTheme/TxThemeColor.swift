//
//  TxThemeColor.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import TxDesignSystem
// swiftlint:disable function_body_length
extension TxDesignSystem {
    public struct ThemeColor {
        public let backgroundGray: SwiftUI.Color
        public let backgroundWhite: SwiftUI.Color
        // Surface
        public let surfaceBrand: SwiftUI.Color
        public let surfaceWhite: SwiftUI.Color
        public let surfaceGray: SwiftUI.Color
        public let surfaceDisable: SwiftUI.Color
        public let surfaceBottomSheet: SwiftUI.Color
        public let surfacePopup: SwiftUI.Color
        public let surfaceWarningHighlight: SwiftUI.Color
        public let surfaceWarning: SwiftUI.Color
        public let surfaceErrorHighlight: SwiftUI.Color
        public let surfaceError: SwiftUI.Color
        public let surfaceSuccessHighlight: SwiftUI.Color
        public let surfaceSuccess: SwiftUI.Color
        public let surfaceInformationHighlight: SwiftUI.Color
        public let surfaceInformation: SwiftUI.Color
        public let surfacePendingHighlight: SwiftUI.Color
        public let surfacePending: SwiftUI.Color
        public let surfaceSelected: SwiftUI.Color
        public let surfaceHover: SwiftUI.Color

        // Text
        public let textPrimary: SwiftUI.Color
        public let textSecondary: SwiftUI.Color
        public let textTertiary: SwiftUI.Color
        public let textPlaceholder: SwiftUI.Color
        public let textDisable: SwiftUI.Color
        public let textInverse: SwiftUI.Color
        public let textLink: SwiftUI.Color
        public let textLinkHover: SwiftUI.Color
        public let textLinkPressed: SwiftUI.Color
        public let textBrand: SwiftUI.Color
        public let textBrandHover: SwiftUI.Color
        public let textBrandPressed: SwiftUI.Color
        public let textInformation: SwiftUI.Color
        public let textSuccess: SwiftUI.Color
        public let textError: SwiftUI.Color
        public let textPending: SwiftUI.Color
        public let textWarning: SwiftUI.Color

        // Icon
        public let iconDefault: SwiftUI.Color
        public let iconDisable: SwiftUI.Color
        public let iconInverse: SwiftUI.Color
        public let iconBrand: SwiftUI.Color
        public let iconPending: SwiftUI.Color
        public let iconInformation: SwiftUI.Color
        public let iconError: SwiftUI.Color
        public let iconSuccess: SwiftUI.Color
        public let iconWarning: SwiftUI.Color

        // boder
        public let boderWarning: SwiftUI.Color
        public let boderInformation: SwiftUI.Color
        public let boderError: SwiftUI.Color
        public let boderPending: SwiftUI.Color
        public let boderFocus: SwiftUI.Color
        public let boderSuccess: SwiftUI.Color
        public let boderBrand: SwiftUI.Color
        public let boderHover: SwiftUI.Color
        public let boderDefault: SwiftUI.Color
        public let boderDisable: SwiftUI.Color
        public let boderInverse: SwiftUI.Color

        public init(themeColorDTO: TxThemeColorDTO) {
            self.backgroundGray = SwiftUI.Color(hex: themeColorDTO.backgroundGray)
            self.backgroundWhite = SwiftUI.Color(hex: themeColorDTO.backgroundWhite)
            self.surfaceBrand = SwiftUI.Color(hex: themeColorDTO.surfaceBrand)
            self.surfaceWhite = SwiftUI.Color(hex: themeColorDTO.surfaceWhite)
            self.surfaceGray = SwiftUI.Color(hex: themeColorDTO.surfaceGray)
            self.surfaceDisable = SwiftUI.Color(hex: themeColorDTO.surfaceDisable)
            self.surfaceBottomSheet = SwiftUI.Color(hex: themeColorDTO.surfaceBottomSheet)
            self.surfacePopup = SwiftUI.Color(hex: themeColorDTO.surfacePopup)
            self.surfaceWarningHighlight = SwiftUI.Color(hex: themeColorDTO.surfaceWarningHighlight)
            self.surfaceWarning = SwiftUI.Color(hex: themeColorDTO.surfaceWarning)
            self.surfaceErrorHighlight = SwiftUI.Color(hex: themeColorDTO.surfaceErrorHighlight)
            self.surfaceError = SwiftUI.Color(hex: themeColorDTO.surfaceError)
            self.surfaceSuccessHighlight = SwiftUI.Color(hex: themeColorDTO.surfaceSuccessHighlight)
            self.surfaceSuccess = SwiftUI.Color(hex: themeColorDTO.surfaceSuccess)
            self.surfaceInformationHighlight = SwiftUI.Color(hex: themeColorDTO.surfaceInformationHighlight)
            self.surfaceInformation = SwiftUI.Color(hex: themeColorDTO.surfaceInformation)
            self.surfacePendingHighlight = SwiftUI.Color(hex: themeColorDTO.surfacePendingHighlight)
            self.surfacePending = SwiftUI.Color(hex: themeColorDTO.surfacePending)
            self.surfaceSelected = SwiftUI.Color(hex: themeColorDTO.surfaceSelected)
            self.surfaceHover = SwiftUI.Color(hex: themeColorDTO.surfaceHover)
            self.textPrimary = SwiftUI.Color(hex: themeColorDTO.textPrimary)
            self.textSecondary = SwiftUI.Color(hex: themeColorDTO.textSecondary)
            self.textTertiary = SwiftUI.Color(hex: themeColorDTO.textTertiary)
            self.textPlaceholder = SwiftUI.Color(hex: themeColorDTO.textPlaceholder)
            self.textDisable = SwiftUI.Color(hex: themeColorDTO.textDisable)
            self.textInverse = SwiftUI.Color(hex: themeColorDTO.textInverse)
            self.textLink = SwiftUI.Color(hex: themeColorDTO.textLink)
            self.textLinkHover = SwiftUI.Color(hex: themeColorDTO.textLinkHover)
            self.textLinkPressed = SwiftUI.Color(hex: themeColorDTO.textLinkPressed)
            self.textBrand = SwiftUI.Color(hex: themeColorDTO.textBrand)
            self.textBrandHover = SwiftUI.Color(hex: themeColorDTO.textBrandHover)
            self.textBrandPressed = SwiftUI.Color(hex: themeColorDTO.textBrandPressed)
            self.textInformation = SwiftUI.Color(hex: themeColorDTO.textInformation)
            self.textSuccess = SwiftUI.Color(hex: themeColorDTO.textSuccess)
            self.textError = SwiftUI.Color(hex: themeColorDTO.textError)
            self.textPending = SwiftUI.Color(hex: themeColorDTO.textPending)
            self.textWarning = SwiftUI.Color(hex: themeColorDTO.textWarning)
            self.iconDefault = SwiftUI.Color(hex: themeColorDTO.iconDefault)
            self.iconDisable = SwiftUI.Color(hex: themeColorDTO.iconDisable)
            self.iconInverse = SwiftUI.Color(hex: themeColorDTO.iconInverse)
            self.iconBrand = SwiftUI.Color(hex: themeColorDTO.iconBrand)
            self.iconPending = SwiftUI.Color(hex: themeColorDTO.iconPending)
            self.iconInformation = SwiftUI.Color(hex: themeColorDTO.iconInformation)
            self.iconError = SwiftUI.Color(hex: themeColorDTO.iconError)
            self.iconSuccess = SwiftUI.Color(hex: themeColorDTO.iconSuccess)
            self.iconWarning = SwiftUI.Color(hex: themeColorDTO.iconWarning)
            self.boderWarning = SwiftUI.Color(hex: themeColorDTO.boderWarning)
            self.boderInformation = SwiftUI.Color(hex: themeColorDTO.boderInformation)
            self.boderError = SwiftUI.Color(hex: themeColorDTO.boderError)
            self.boderPending = SwiftUI.Color(hex: themeColorDTO.boderPending)
            self.boderFocus = SwiftUI.Color(hex: themeColorDTO.boderFocus)
            self.boderSuccess = SwiftUI.Color(hex: themeColorDTO.boderSuccess)
            self.boderBrand = SwiftUI.Color(hex: themeColorDTO.boderBrand)
            self.boderHover = SwiftUI.Color(hex: themeColorDTO.boderHover)
            self.boderDefault = SwiftUI.Color(hex: themeColorDTO.boderDefault)
            self.boderDisable = SwiftUI.Color(hex: themeColorDTO.boderDisable)
            self.boderInverse = SwiftUI.Color(hex: themeColorDTO.boderInverse)
        }
    }
}

// swiftlint:enable function_body_length
