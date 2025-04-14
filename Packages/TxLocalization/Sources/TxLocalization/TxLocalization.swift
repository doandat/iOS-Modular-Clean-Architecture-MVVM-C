// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// Class responsible for managing localization in the application.
///
/// This class provides functionality to:
/// - Support multiple languages (English and Vietnamese)
/// - Persist language preference using UserDefaults
/// - Load localized strings from bundles
/// - Format localized strings with arguments
/// - Get locale information for the current language
public final class L10n: ObservableObject {
    /// Enum defining the supported languages in the application.
    public enum Language: String, CaseIterable, Equatable {
        /// Vietnamese language
        case vi
        
        /// English language
        case en
    }
    
    /// Key used to store the selected language in UserDefaults.
    private static let languageUserDefaultsKey: String = "Tx_AppLanguage"
    
    /// The currently selected language.
    /// When set, the value is automatically persisted to UserDefaults.
    @Published public var currentLanguage: Language {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: L10n.languageUserDefaultsKey)
        }
    }
    
    /// Creates a new L10n instance.
    /// The language is initialized from UserDefaults, defaulting to English if no saved preference exists.
    public init() {
        let savedLanguage = UserDefaults.standard.string(forKey: L10n.languageUserDefaultsKey) ?? ""
        self.currentLanguage = Language(rawValue: savedLanguage) ?? .en
    }
    
    /// Retrieves a localized string with variable arguments.
    ///
    /// - Parameters:
    ///   - key: The key of the localized string
    ///   - args: Variable number of arguments to format into the string
    ///   - table: The strings table to use (defaults to "Localizable")
    ///   - bundle: The bundle containing the localization
    /// - Returns: The formatted localized string
    public func localized(key: String, _ args: CVarArg..., table: String = "Localizable", in bundle: Bundle) -> String {
        let format = localizedString(forKey:table:in:)(key, table, bundle)
        return String(format: format, locale: Locale.current, arguments: args)
    }
    
    /// Retrieves a localized string with an array of arguments.
    ///
    /// - Parameters:
    ///   - key: The key of the localized string
    ///   - arguments: Array of arguments to format into the string
    ///   - table: The strings table to use (defaults to "Localizable")
    ///   - bundle: The bundle containing the localization
    /// - Returns: The formatted localized string
    public func localized(key: String, arguments: [CVarArg], table: String = "Localizable", in bundle: Bundle) -> String {
        let format = localizedString(forKey: table: in:)(key, table, bundle)
        return String(format: format, locale: Locale.current, arguments: arguments)
    }
    
    /// Internal method to retrieve a localized string from a bundle.
    ///
    /// - Parameters:
    ///   - forKey: The key of the localized string
    ///   - table: The strings table to use
    ///   - bundle: The bundle containing the localization
    /// - Returns: The localized string, or the key itself if no translation is found
    func localizedString(forKey: String, table: String?, in bundle: Bundle) -> String {
        let localizeBundle: Bundle = {
            guard let path = bundle.path(forResource: currentLanguage.rawValue, ofType: "lproj") else {
                return bundle
            }
            return Bundle(path: path) ?? bundle
        }()
        return localizeBundle.localizedString(forKey: forKey, value: nil, table: table)
    }
    
    /// Updates the current language of the application.
    ///
    /// - Parameter language: The new language to set
    public func update(to language: Language) {
        self.currentLanguage = language
    }
    
    /// Returns the locale corresponding to the current language.
    ///
    /// - Returns: A Locale instance for the current language
    public func locale() -> Locale {
        switch currentLanguage {
        case .en:
            return .init(identifier: "en_US")
        case .vi:
            return .init(identifier: "vi_VN")
        }
    }
}
