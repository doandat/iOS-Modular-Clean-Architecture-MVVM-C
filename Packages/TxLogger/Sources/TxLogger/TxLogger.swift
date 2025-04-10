// The Swift Programming Language
// https://docs.swift.org/swift-book

import os
import Foundation

// Define your LogLevel for filtering logs
public enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

// Wrapper Log class
public class TxLogger {
    private let logger: Logger
    private let subsystem: String
    private let category: String

    public init(subsystem: String = Bundle.main.bundleIdentifier ?? "DefaultSubsystem", category: String = "") {
        self.subsystem = subsystem
        self.category = category
        self.logger = Logger(subsystem: subsystem, category: category)
    }

    // Log a message with a specific log level
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

    // Convenience methods
    public func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.debug, message, file: file, function: function, line: line)
    }

    public func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.info, message, file: file, function: function, line: line)
    }

    public func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.warning, message, file: file, function: function, line: line)
    }

    public func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(.error, message, file: file, function: function, line: line)
    }
    
    public func error(_ error: Error, file: String = #file, function: String = #function, line: Int = #line) {
#if DEBUG
        print(error)
#endif
    }
    
    public func debug(_ items: Any...) {
#if DEBUG
        print(items)
#endif
    }
    
}
