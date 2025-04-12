// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class L10n: ObservableObject {
    public enum Language: String, CaseIterable, Equatable {
        case vi
        case en
    }
    
    private static let languageUserDefaultsKey: String = "Tx_AppLanguage"
    
    @Published public var currentLanguage: Language {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: L10n.languageUserDefaultsKey)
        }
    }
    
    public init() {
        let savedLanguage = UserDefaults.standard.string(forKey: L10n.languageUserDefaultsKey) ?? ""
        self.currentLanguage = Language(rawValue: savedLanguage) ?? .en
    }
    
    public func localized(key: String, _ args: CVarArg..., table: String = "Localizable", in bundle: Bundle) -> String {
        let format = localizedString(forKey:table:in:)(key, table, bundle)
        return String(format: format, locale: Locale.current, arguments: args)
    }
    
    public func localized(key: String, arguments: [CVarArg], table: String = "Localizable", in bundle: Bundle) -> String {
        let format = localizedString(forKey: table: in:)(key, table, bundle)
        return String(format: format, locale: Locale.current, arguments: arguments)
    }
    
    func localizedString(forKey: String, table: String?, in bundle: Bundle) -> String {
        let localizeBundle: Bundle = {
            guard let path = bundle.path(forResource: currentLanguage.rawValue, ofType: "lproj") else {
                return bundle
            }
            return Bundle(path: path) ?? bundle
        }()
        return localizeBundle.localizedString(forKey: forKey, value: nil, table: table)
    }
    
    public func update(to language: Language) {
        self.currentLanguage = language
    }
    
    public func locale() -> Locale {
        switch currentLanguage {
        case .en:
            return .init(identifier: "en_US")
        case .vi:
            return .init(identifier: "vi_VN")
        }
    }
}
