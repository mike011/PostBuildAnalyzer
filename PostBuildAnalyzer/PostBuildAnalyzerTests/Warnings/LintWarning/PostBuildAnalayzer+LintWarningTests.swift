//
//  PostBuildAnalayzer+LintWarningTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2021-06-09.
//  Copyright © 2021 Michael Charland. All rights reserved.
//

import Testing

@Suite struct PostBuildAnalayzer_LintWarningTests {

    @Test func notAWarning() {
        var lintFile = [String]()
        lintFile.append("Not a warning")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: lintFile, ignorePaths: [])
        #expect(wa.allWarnings.isEmpty)
    }
    
    @Test func aWarning() {
        var lintFile = [String]()
        lintFile.append("<td>Example/SlowFiles.swift</td>")
        lintFile.append("")
        lintFile.append("<td class=\"warning\">Warning</td>")
        lintFile.append("<td>Collection literals should not have trailing commas.</td>")
        
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: lintFile, ignorePaths: [])
        #expect(!wa.allWarnings.isEmpty)
    }
    
    @Test func anErrorNotHandled() {
        var lintFile = [String]()
        lintFile.append("<td>Example/LongFiles.swift</td>")
        lintFile.append("")
        lintFile.append("<td class=\"error\">Error</td>")
        lintFile.append("<td>Line should be 200 characters or less: currently 252 characters.</td>")
        
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: lintFile, ignorePaths: [])
        #expect(wa.allWarnings.isEmpty)
    }
}
