//
//  PostBuildComparisonTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class PostBuildComparisonTests: XCTestCase {
    func testGetNewWarningsTable() {
        let before = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String]())

        var logFile = [String]()
        logFile.append(": warning: ")
        let after = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)

        // let pbc = PostBuildComparsion(before: before, after: after)
        // XCTAssertFalse(pbc.getNewWarningsTable().isEmpty)
    }

    // func get
}
