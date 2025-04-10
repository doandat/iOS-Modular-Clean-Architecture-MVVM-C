//
//  String+Extensions.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import Resolver
import UIKit
import TxLocalization

extension String {
    internal func localization(_ args: CVarArg...) -> String {
        return Resolver.resolve(L10n.self).localized(key: self, arguments: args, in: Bundle.txGitProfile)
    }
}
