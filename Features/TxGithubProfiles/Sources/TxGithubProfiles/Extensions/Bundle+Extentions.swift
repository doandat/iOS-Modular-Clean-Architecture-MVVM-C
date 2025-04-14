//
//  Bundle+Extentions.swift
//
//  Created by doandat on 10/4/25.
//

import UIKit

/// Extension providing bundle access for the GitHub Profiles module.
///
/// This extension adds functionality to access the module's bundle,
/// which is used for loading resources like images and localized strings.
extension Bundle {
    /// The bundle containing resources for the GitHub Profiles module.
    ///
    /// This static property provides access to the module's bundle,
    /// which is used for loading resources like:
    /// - Localized strings
    /// - Images
    /// - Other bundled assets
    public static let txGitProfile: Bundle = {
        Bundle.module
    }()
}
