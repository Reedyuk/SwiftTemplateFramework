//
//  LoggingTests.swift
//  SwiftTemplateFramework
//
//  Created by Andrew Reed on 08/01/2017.
//  Copyright © 2017 Andrew Reed. All rights reserved.
//

import XCTest
@testable import SwiftTemplateFramework

class LoggingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        LoggingService.sharedInstance.initialise(appDelegateWindow: nil)
        LoggingService.sharedInstance.enableFileLogging()
    }

    private func getLogFileContents() -> String? {
        do {
            return try String(contentsOf: URL(fileURLWithPath: LoggingService.sharedInstance.getFileLogLocation()))
        } catch {
            return nil
        }
    }

    func testDebug() {
        let logString = "Test Debug"
        LoggingService.debug(logString)
        Thread.sleep(forTimeInterval: 1)
        XCTAssertTrue(getLogFileContents()!.contains(logString))
    }

    func testInfo() {
        let logString = "Test Info"
        LoggingService.info(logString)
        Thread.sleep(forTimeInterval: 1)
        XCTAssertTrue(getLogFileContents()!.contains(logString))
    }

    func testError() {
        let logString = "Test Error"
        LoggingService.error(logString)
        Thread.sleep(forTimeInterval: 1)
        XCTAssertTrue(getLogFileContents()!.contains(logString))
    }

    func testVerbose() {
        let logString = "Test Verbose"
        LoggingService.verbose(logString)
        Thread.sleep(forTimeInterval: 1)
        XCTAssertTrue(getLogFileContents()!.contains(logString))
    }

    func testWarning() {
        let logString = "Test Warning"
        LoggingService.warning(logString)
        Thread.sleep(forTimeInterval: 1)
        XCTAssertTrue(getLogFileContents()!.contains(logString))
    }

}
