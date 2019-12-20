//
//  WarningAnalyzerTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class WarningAnalyzerTests: XCTestCase {

    func testNotAWarning() {
        var logFile = [String]()
        logFile.append("Not a warning")
        let wa = WarningAnalyzer(logFile: logFile)
        XCTAssertTrue(wa.warnings.isEmpty)
    }

    func testAWarning() {
        var logFile = [String]()
        logFile.append(": warning :")
        let wa = WarningAnalyzer(logFile: logFile)
        XCTAssertTrue(wa.warnings.isEmpty)
    }

}
