// The Swift Programming Language
// https://docs.swift.org/swift-book

import os
import Foundation

/// Enum defining the available log levels for filtering and categorizing logs.
///
/// The levels are ordered by severity:
/// - debug: For detailed debugging information
/// - info: For general informational messages
/// - warning: For potentially harmful situations
/// - error: For error events that might still allow the application to continue running
public enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

/// A wrapper class for logging functionality that provides a unified interface for logging across the application.
///
/// This class uses the OSLog framework for logging in production and provides additional debugging capabilities
/// when running in debug mode or Xcode previews.
public class TxLogger {
    private let logger: Logger
    private let subsystem: String
    private let category: String

    /// Creates a new logger instance with the specified subsystem and category.
    ///
    /// - Parameters:
    ///   - subsystem: The subsystem identifier (defaults to the main bundle identifier)
    ///   - category: The category for the logger (defaults to empty string)
    public init(subsystem: String = Bundle.main.bundleIdentifier ?? "DefaultSubsystem", category: String = "") {
        self.subsystem = subsystem
        self.category = category
        self.logger = Logger(subsystem: subsystem, category: category)
    }

    /// Logs a message with the specified log level and includes file, function, and line information.
    ///
    /// - Parameters:
    ///   - level: The severity level of the log message
    ///   - message: The message to log
    ///   - file: The source file name (automatically captured)
    ///   - function: The function name (automatically captured)
    ///   - line: The line number (automatically captured)
    func log(_ level: LogLevel, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        let fullMessage = "[\(fileName):\(line)] \(function) - \(message)"
        switch level {
        case .debug:
#if DEBUG
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                print(fullMessage)
            } else {
                logger.debug("\(fullMessage)")
            }
#endif
        case .info:
#if DEBUG
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                print(fullMessage)
            } else {
                
                logger.info("\(fullMessage)")
            }
#endif
        case .warning:
#if DEBUG
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                print(fullMessage)
            } else {
                logger.warning("\(fullMessage)")
            }
#endif
        case .error:
#if DEBUG
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                print(fullMessage)
            } else {
                logger.error("\(fullMessage)")
            }
#endif
        }
    }

    /// Logs a debug level message.
    ///
    /// - Parameters:
    ///   - message: The message to log
    ///   - file: The source file name (automatically captured)
    ///   - function: The function name (automatically captured)
    ///   - line: The line number (automatically captured)
    public func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.debug, message, file: file, function: function, line: line)
    }

    /// Logs an info level message.
    ///
    /// - Parameters:
    ///   - message: The message to log
    ///   - file: The source file name (automatically captured)
    ///   - function: The function name (automatically captured)
    ///   - line: The line number (automatically captured)
    public func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.info, message, file: file, function: function, line: line)
    }

    /// Logs a warning level message.
    ///
    /// - Parameters:
    ///   - message: The message to log
    ///   - file: The source file name (automatically captured)
    ///   - function: The function name (automatically captured)
    ///   - line: The line number (automatically captured)
    public func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.warning, message, file: file, function: function, line: line)
    }

    /// Logs an error level message.
    ///
    /// - Parameters:
    ///   - message: The message to log
    ///   - file: The source file name (automatically captured)
    ///   - function: The function name (automatically captured)
    ///   - line: The line number (automatically captured)
    public func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.error, message, file: file, function: function, line: line)
    }
    
    /// Logs an error object.
    ///
    /// - Parameters:
    ///   - error: The error to log
    ///   - file: The source file name (automatically captured)
    ///   - function: The function name (automatically captured)
    ///   - line: The line number (automatically captured)
    public func error(_ error: Error, file: String = #file, function: String = #function, line: Int = #line) {
#if DEBUG
        print(error)
#endif
    }
    
    /// Logs debug information for multiple items.
    ///
    /// - Parameter items: The items to log
    public func debug(_ items: Any...) {
#if DEBUG
        print(items)
#endif
    }
}
