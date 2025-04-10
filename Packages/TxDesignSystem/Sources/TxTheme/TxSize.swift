//
//  TxSize.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//
import TxDesignSystem

extension TxDesignSystem.Size {
    public enum Global: Double {
        case size0 = 0
        case size10 = 0.5
        case size25 = 1
        case size50 = 2
        case size70 = 3
        case size100 = 4
        case size150 = 6
        case size200 = 8
        case size300 = 12
        case size400 = 16
        case size500 = 20
        case size600 = 24
        case size800 = 32
        case size1000 = 40
        case size1100 = 44
        case size1200 = 48
        case size1600 = 64
        case size2400 = 96
        case size4000 = 160
        case sizeMax = 99999
    }
}

public typealias TxSize = TxDesignSystem.Size.Global
