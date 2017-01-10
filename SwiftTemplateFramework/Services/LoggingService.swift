//
//  LoggingService.swift
//
//
//  Created by Andrew Reed on 24/07/2016.
//  Copyright © 2016. All rights reserved.
//

import UIKit
import Siesta
import CocoaLumberjack

/// Class we use for logging!
public class LoggingService {
    public static let sharedInstance = LoggingService()   ///singleton
    private let fileLogger: DDFileLogger = DDFileLogger() // File Logger

    /// Constructor to setup key etc.
    init() {
        DDLog.add(DDTTYLogger.sharedInstance()) // TTY = Xcode console
        DDLog.add(DDASLLogger.sharedInstance()) // ASL = Apple System Logs
        DDTTYLogger.sharedInstance().colorsEnabled = true
    }

    public func enableFileLogging() {
        fileLogger.doNotReuseLogFiles = true
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }

    public func getFileLogLocation() -> String {
        return fileLogger.currentLogFileInfo.filePath
    }

    /// The method to initialise the logging service
    public func initialise() {
        let originalLogger = Siesta.logger
        Siesta.logger = { category, message in
            originalLogger(category, message)
            if category == .network {
                LoggingService.info(message)
            }
        }
    }

    /// Method to log verbose messages
    /// - Parameter message: The message we want to log
    public static func verbose(_ message: String) {
        DDLogVerbose(message)
    }

    /// Method to log info messages
    /// - Parameter message: The message we want to log
    public static func info(_ message: String) {
        DDLogInfo(message)
    }

    /// Method to log warning messages
    /// - Parameter message: The message we want to log
    public static func warning(_ message: String) {
        DDLogWarn(message)
    }

    /// Method to log error messages
    /// - Parameter message: The message we want to log
    public static func error(_ message: String) {
        DDLogError(message)
    }

    /// Method to log debug messages
    /// - Parameter message: The message we want to log
    public static func debug(_ message: String) {
        DDLogDebug(message)
    }
}
