//
//  TxThemeManager.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import Combine
import TxDesignSystem

public class TxThemeManager: ObservableObject {

    @Published public var selectedColor: TxDesignSystem.ThemeColor

    public init() {
        self.selectedColor = .init(themeColorDTO: .lightMode)
    }

    public func setTheme(_ color: TxDesignSystem.ThemeColor) {
        selectedColor = color
    }

}
