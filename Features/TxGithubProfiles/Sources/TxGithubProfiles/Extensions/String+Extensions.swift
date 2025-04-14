//
//  String+Extensions.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import Resolver
import UIKit
import TxLocalization

/// Extension providing localization functionality for strings in the GitHub Profiles module.
///
/// This extension adds methods to handle string localization,
/// making it easier to support multiple languages in the app.
extension String {
    /// Localizes a string using the GitHub Profiles module's bundle.
    ///
    /// This method:
    /// - Uses the module's bundle to find localized strings
    /// - Supports string formatting with arguments
    /// - Integrates with the app's localization system
    ///
    /// - Parameter args: Optional arguments to be inserted into the localized string.
    /// - Returns: The localized string, or the original string if no localization is found.
    internal func localization(_ args: CVarArg...) -> String {
        return Resolver.resolve(L10n.self).localized(key: self, arguments: args, in: Bundle.txGitProfile)
    }
}
