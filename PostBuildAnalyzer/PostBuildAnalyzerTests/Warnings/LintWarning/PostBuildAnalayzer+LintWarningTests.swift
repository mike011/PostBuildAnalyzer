//
//  PostBuildAnalayzer+LintWarningTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2021-06-09.
//  Copyright © 2021 Michael Charland. All rights reserved.
//

import XCTest

class PostBuildAnalayzer_LintWarningTests: XCTestCase {

    func testNotAWarning() {
        var lintFile = [String]()
        lintFile.append("Not a warning")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: lintFile)
        XCTAssertTrue(wa.allWarnings.isEmpty)
    }
    
    func testAWarning() {
        var lintFile = [String]()
        lintFile.append("<td>Example/SlowFiles.swift</td>")
        lintFile.append("")
        lintFile.append("<td class=\"warning\">Warning</td>")
        lintFile.append("<td>Collection literals should not have trailing commas.</td>")
        
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: lintFile)
        XCTAssertFalse(wa.allWarnings.isEmpty)
    }
    
    func testAnErrorNotHandled() {
        var lintFile = [String]()
        lintFile.append("<td>Example/LongFiles.swift</td>")
        lintFile.append("")
        lintFile.append("<td class=\"error\">Error</td>")
        lintFile.append("<td>Line should be 200 characters or less: currently 252 characters.</td>")
        
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: lintFile)
        XCTAssertTrue(wa.allWarnings.isEmpty)
    }
}
