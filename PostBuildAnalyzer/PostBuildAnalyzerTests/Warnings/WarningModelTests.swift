//
//  WarningModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-28.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class WarningModelTests: XCTestCase {
    func testCompareToSame() {
        let model = MockWarningModel()
        XCTAssertTrue(model.compareTo(line: ""))
    }

    func testCompareToDifferent() {
        let model = MockWarningModel()
        XCTAssertFalse(model.compareTo(line: "different"))
    }
}
