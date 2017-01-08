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

    func testDebug() {
        LoggingService.debug("Test Debug")
    }

}
