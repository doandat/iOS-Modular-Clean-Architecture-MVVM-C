//
//  TxDeeplinkPath.swift
//  TxDeeplink
//
//  Created by doandat on 10/4/25.
//

import Foundation

/// Base enum for defining deep link paths in the application.
///
/// This enum serves as a namespace for different types of deep link paths.
/// Each feature or module should extend this enum with its own path definitions.
///
/// Example:
/// ```swift
/// extension TxDeeplinkPath {
///     enum FeatureA: String {
///         case screen1 = "/featureA/screen1"
///         case screen2 = "/featureA/screen2"
///     }
/// }
/// ```
public enum TxDeeplinkPath {}

