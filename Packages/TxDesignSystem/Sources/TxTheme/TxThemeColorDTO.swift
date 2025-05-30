import Foundation
// swiftlint:disable type_body_length function_body_length

/// Data transfer object for theme colors.
///
/// This struct provides:
/// - Color definitions in hex format
/// - Light and dark mode presets
/// - Color categories (background, surface, text, icon, border)
public struct TxThemeColorDTO: Decodable {
    // Background colors
    let backgroundPrimary: String
    let backgroundSecondary: String
    
    // Surface colors
    let surfaceBrand: String
    let surfaceWhite: String
    let surfaceGray: String
    let surfaceDisable: String
    let surfaceBottomSheet: String
    let surfacePopup: String
    let surfaceWarningHighlight: String
    let surfaceWarning: String
    let surfaceErrorHighlight: String
    let surfaceError: String
    let surfaceSuccessHighlight: String
    let surfaceSuccess: String
    let surfaceInformationHighlight: String
    let surfaceInformation: String
    let surfacePendingHighlight: String
    let surfacePending: String
    let surfaceSelected: String
    let surfaceHover: String
    
    // Text colors
    let textPrimary: String
    let textSecondary: String
    let textTertiary: String
    let textPlaceholder: String
    let textDisable: String
    let textInverse: String
    let textLink: String
    let textLinkHover: String
    let textLinkPressed: String
    let textBrand: String
    let textBrandHover: String
    let textBrandPressed: String
    let textInformation: String
    let textSuccess: String
    let textError: String
    let textPending: String
    let textWarning: String
    
    // Icon colors
    let iconDefault: String
    let iconDisable: String
    let iconInverse: String
    let iconBrand: String
    let iconPending: String
    let iconInformation: String
    let iconError: String
    let iconSuccess: String
    let iconWarning: String
    
    // Border colors
    let boderWarning: String
    let boderInformation: String
    let boderError: String
    let boderPending: String
    let boderFocus: String
    let boderSuccess: String
    let boderBrand: String
    let boderHover: String
    let boderDefault: String
    let boderDisable: String
    let boderInverse: String
    
    /// Creates a new theme color DTO.
    ///
    /// - Parameters:
    ///   - backgroundPrimary: Background primary color
    ///   - backgroundSecondary: Background secondary color
    ///   - surfaceBrand: Brand surface color
    ///   - surfaceWhite: White surface color
    ///   - surfaceGray: Gray surface color
    ///   - surfaceDisable: Disabled surface color
    ///   - surfaceBottomSheet: Bottom sheet surface color
    ///   - surfacePopup: Popup surface color
    ///   - surfaceWarningHighlight: Warning highlight surface color
    ///   - surfaceWarning: Warning surface color
    ///   - surfaceErrorHighlight: Error highlight surface color
    ///   - surfaceError: Error surface color
    ///   - surfaceSuccessHighlight: Success highlight surface color
    ///   - surfaceSuccess: Success surface color
    ///   - surfaceInformationHighlight: Information highlight surface color
    ///   - surfaceInformation: Information surface color
    ///   - surfacePendingHighlight: Pending highlight surface color
    ///   - surfacePending: Pending surface color
    ///   - surfaceSelected: Selected surface color
    ///   - surfaceHover: Hover surface color
    ///   - textPrimary: Primary text color
    ///   - textSecondary: Secondary text color
    ///   - textTertiary: Tertiary text color
    ///   - textPlaceholder: Placeholder text color
    ///   - textDisable: Disabled text color
    ///   - textInverse: Inverse text color
    ///   - textLink: Link text color
    ///   - textLinkHover: Link hover text color
    ///   - textLinkPressed: Link pressed text color
    ///   - textBrand: Brand text color
    ///   - textBrandHover: Brand hover text color
    ///   - textBrandPressed: Brand pressed text color
    ///   - textInformation: Information text color
    ///   - textSuccess: Success text color
    ///   - textError: Error text color
    ///   - textPending: Pending text color
    ///   - textWarning: Warning text color
    ///   - iconDefault: Default icon color
    ///   - iconDisable: Disabled icon color
    ///   - iconInverse: Inverse icon color
    ///   - iconBrand: Brand icon color
    ///   - iconPending: Pending icon color
    ///   - iconInformation: Information icon color
    ///   - iconError: Error icon color
    ///   - iconSuccess: Success icon color
    ///   - iconWarning: Warning icon color
    ///   - boderWarning: Warning border color
    ///   - boderInformation: Information border color
    ///   - boderError: Error border color
    ///   - boderPending: Pending border color
    ///   - boderFocus: Focus border color
    ///   - boderSuccess: Success border color
    ///   - boderBrand: Brand border color
    ///   - boderHover: Hover border color
    ///   - boderDefault: Default border color
    ///   - boderDisable: Disabled border color
    ///   - boderInverse: Inverse border color
    public init(
        backgroundPrimary: String,
        backgroundSecondary: String,
        surfaceBrand: String,
        surfaceWhite: String,
        surfaceGray: String,
        surfaceDisable: String,
        surfaceBottomSheet: String,
        surfacePopup: String,
        surfaceWarningHighlight: String,
        surfaceWarning: String,
        surfaceErrorHighlight: String,
        surfaceError: String,
        surfaceSuccessHighlight: String,
        surfaceSuccess: String,
        surfaceInformationHighlight: String,
        surfaceInformation: String,
        surfacePendingHighlight: String,
        surfacePending: String,
        surfaceSelected: String,
        surfaceHover: String,
        textPrimary: String,
        textSecondary: String,
        textTertiary: String,
        textPlaceholder: String,
        textDisable: String,
        textInverse: String,
        textLink: String,
        textLinkHover: String,
        textLinkPressed: String,
        textBrand: String,
        textBrandHover: String,
        textBrandPressed: String,
        textInformation: String,
        textSuccess: String,
        textError: String,
        textPending: String,
        textWarning: String,
        iconDefault: String,
        iconDisable: String,
        iconInverse: String,
        iconBrand: String,
        iconPending: String,
        iconInformation: String,
        iconError: String,
        iconSuccess: String,
        iconWarning: String,
        boderWarning: String,
        boderInformation: String,
        boderError: String,
        boderPending: String,
        boderFocus: String,
        boderSuccess: String,
        boderBrand: String,
        boderHover: String,
        boderDefault: String,
        boderDisable: String,
        boderInverse: String
    ) {
        self.backgroundPrimary = backgroundPrimary
        self.backgroundSecondary = backgroundSecondary
        self.surfaceBrand = surfaceBrand
        self.surfaceWhite = surfaceWhite
        self.surfaceGray = surfaceGray
        self.surfaceDisable = surfaceDisable
        self.surfaceBottomSheet = surfaceBottomSheet
        self.surfacePopup = surfacePopup
        self.surfaceWarningHighlight = surfaceWarningHighlight
        self.surfaceWarning = surfaceWarning
        self.surfaceErrorHighlight = surfaceErrorHighlight
        self.surfaceError = surfaceError
        self.surfaceSuccessHighlight = surfaceSuccessHighlight
        self.surfaceSuccess = surfaceSuccess
        self.surfaceInformationHighlight = surfaceInformationHighlight
        self.surfaceInformation = surfaceInformation
        self.surfacePendingHighlight = surfacePendingHighlight
        self.surfacePending = surfacePending
        self.surfaceSelected = surfaceSelected
        self.surfaceHover = surfaceHover
        self.textPrimary = textPrimary
        self.textSecondary = textSecondary
        self.textTertiary = textTertiary
        self.textPlaceholder = textPlaceholder
        self.textDisable = textDisable
        self.textInverse = textInverse
        self.textLink = textLink
        self.textLinkHover = textLinkHover
        self.textLinkPressed = textLinkPressed
        self.textBrand = textBrand
        self.textBrandHover = textBrandHover
        self.textBrandPressed = textBrandPressed
        self.textInformation = textInformation
        self.textSuccess = textSuccess
        self.textError = textError
        self.textPending = textPending
        self.textWarning = textWarning
        self.iconDefault = iconDefault
        self.iconDisable = iconDisable
        self.iconInverse = iconInverse
        self.iconBrand = iconBrand
        self.iconPending = iconPending
        self.iconInformation = iconInformation
        self.iconError = iconError
        self.iconSuccess = iconSuccess
        self.iconWarning = iconWarning
        self.boderWarning = boderWarning
        self.boderInformation = boderInformation
        self.boderError = boderError
        self.boderPending = boderPending
        self.boderFocus = boderFocus
        self.boderSuccess = boderSuccess
        self.boderBrand = boderBrand
        self.boderHover = boderHover
        self.boderDefault = boderDefault
        self.boderDisable = boderDisable
        self.boderInverse = boderInverse
    }
    
    /// Light mode color preset.
    public static var lightMode: TxThemeColorDTO {
        return .init(
            backgroundPrimary: "#F5F5F5",
            backgroundSecondary: "#FFFFFF",
            surfaceBrand: "#4A90E2",
            surfaceWhite: "#FFFFFF",
            surfaceGray: "#E0E0E0",
            surfaceDisable: "#BDBDBD",
            surfaceBottomSheet: "#FFFFFF",
            surfacePopup: "#FFFFFF",
            surfaceWarningHighlight: "#FFEB3B",
            surfaceWarning: "#FF9800",
            surfaceErrorHighlight: "#F44336",
            surfaceError: "#D32F2F",
            surfaceSuccessHighlight: "#4CAF50",
            surfaceSuccess: "#388E3C",
            surfaceInformationHighlight: "#2196F3",
            surfaceInformation: "#1976D2",
            surfacePendingHighlight: "#FFC107",
            surfacePending: "#FFA000",
            surfaceSelected: "#E0E0E0",
            surfaceHover: "#D1C4E9",
            textPrimary: "#212121",
            textSecondary: "#757575",
            textTertiary: "#BDBDBD",
            textPlaceholder: "#B0BEC5",
            textDisable: "#9E9E9E",
            textInverse: "#FFFFFF",
            textLink: "#2196F3",
            textLinkHover: "#1976D2",
            textLinkPressed: "#0D47A1",
            textBrand: "#4A90E2",
            textBrandHover: "#357ABD",
            textBrandPressed: "#1D6BB6",
            textInformation: "#2196F3",
            textSuccess: "#4CAF50",
            textError: "#F44336",
            textPending: "#FFC107",
            textWarning: "#FF9800",
            iconDefault: "#212121",
            iconDisable: "#BDBDBD",
            iconInverse: "#FFFFFF",
            iconBrand: "#4A90E2",
            iconPending: "#FFA000",
            iconInformation: "#2196F3",
            iconError: "#F44336",
            iconSuccess: "#4CAF50",
            iconWarning: "#FF9800",
            boderWarning: "#FF9800",
            boderInformation: "#2196F3",
            boderError: "#F44336",
            boderPending: "#FFC107",
            boderFocus: "#81D4FA",
            boderSuccess: "#4CAF50",
            boderBrand: "#4A90E2",
            boderHover: "#BDBDBD",
            boderDefault: "#e8e8e8",
            boderDisable: "#E0E0E0",
            boderInverse: "#FFFFFF"
        )
    }
    
    /// Dark mode color preset.
    public static var darkMode: TxThemeColorDTO {
        return .init(
            backgroundPrimary: "#121212",
            backgroundSecondary: "#1E1E1E",
            surfaceBrand: "#BB86FC",
            surfaceWhite: "#1E1E1E",
            surfaceGray: "#37474F",
            surfaceDisable: "#616161",
            surfaceBottomSheet: "#1E1E1E",
            surfacePopup: "#1E1E1E",
            surfaceWarningHighlight: "#FFD54F",
            surfaceWarning: "#FFAB00",
            surfaceErrorHighlight: "#FF5252",
            surfaceError: "#D50000",
            surfaceSuccessHighlight: "#00E676",
            surfaceSuccess: "#00C853",
            surfaceInformationHighlight: "#40C4FF",
            surfaceInformation: "#00B0FF",
            surfacePendingHighlight: "#FFB74D",
            surfacePending: "#FFA000",
            surfaceSelected: "#424242",
            surfaceHover: "#37474F",
            textPrimary: "#FFFFFF",
            textSecondary: "#B0BEC5",
            textTertiary: "#FFFFFF",
            textPlaceholder: "#90A4AE",
            textDisable: "#BDBDBD",
            textInverse: "#000000",
            textLink: "#BB86FC",
            textLinkHover: "#3700B3",
            textLinkPressed: "#1D6BB6",
            textBrand: "#BB86FC",
            textBrandHover: "#A16FBA",
            textBrandPressed: "#8B5EA9",
            textInformation: "#40C4FF",
            textSuccess: "#00E676",
            textError: "#FF5252",
            textPending: "#FFB74D",
            textWarning: "#FFAB00",
            iconDefault: "#FFFFFF",
            iconDisable: "#BDBDBD",
            iconInverse: "#000000",
            iconBrand: "#BB86FC",
            iconPending: "#FFA000",
            iconInformation: "#40C4FF",
            iconError: "#FF5252",
            iconSuccess: "#00E676",
            iconWarning: "#FFAB00",
            boderWarning: "#FFAB00",
            boderInformation: "#40C4FF",
            boderError: "#FF5252",
            boderPending: "#FFB74D",
            boderFocus: "#03A9F4",
            boderSuccess: "#00E676",
            boderBrand: "#BB86FC",
            boderHover: "#BDBDBD",
            boderDefault: "#BDBDBD",
            boderDisable: "#424242",
            boderInverse: "#FFFFFF"
        )
    }
}

// swiftlint:enable type_body_length function_body_length
