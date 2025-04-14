//
//  TxView.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI

/// A base protocol for all views in the application.
///
/// This protocol provides:
/// - View identification
/// - Common view functionality
/// - View lifecycle tracking
public protocol TxView: View {
    /// The unique identifier for the view
    var identifier: String { get }
}
