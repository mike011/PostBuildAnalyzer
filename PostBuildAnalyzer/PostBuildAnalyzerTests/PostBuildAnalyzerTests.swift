//
//  PostBuildAnalyzerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-31.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class PostBuildAnalyzerTests: XCTestCase {
    func testInitNoWarnings() {
        let args = Arguments(
            repoURL: "repo",
            branch: "branch",
            outputFolder: "output",
            logFileName: "log",
            baseURLPath: "base",
            lintFileName: nil,
            buildTimeThresholdInMS: 100,
            ignorePaths: []
        )
        let pba = PostBuildAnalyzer(args: args)
        XCTAssertTrue(pba.allWarnings.isEmpty)
    }

    func testInitWarnings() {
        let args = Arguments(
            repoURL: "repo",
            branch: "master",
            outputFolder: EXAMPLE_LOG_FOLDER,
            logFileName: EXAMPLE_LOG_FILE_NAME,
            baseURLPath: "base",
            lintFileName: nil,
            buildTimeThresholdInMS: 100,
            ignorePaths: []
        )
        let pba = PostBuildAnalyzer(args: args)
        XCTAssertFalse(pba.allWarnings.isEmpty)
    }

    func testInitWithDuplicateWarnings() {
        var logFile = [String]()
        logFile.append("AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append("AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        let se = pba.getWarningController() as [WarningController]
        XCTAssertEqual(se.count, 1)
        XCTAssertEqual(se[0].getTotalWarnings(), 2)
    }
    
    func testInitWithIgnoredLocation() {
        var logFile = [String]()
        logFile.append("Pods/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: ["Pods"])
        let se = pba.getWarningController() as [WarningController]
        XCTAssertEqual(se.count, 0)
    }

    func testInitWithDuplicateSlowExpression() {
        var logFile = [String]()
        logFile.append("41.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()")
        logFile.append("31.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        let se = pba.getWarningController() as [SlowExpressionController]
        XCTAssertEqual(se.count, 1)
        XCTAssertEqual(se[0].getTotalWarnings(), 72.76)
    }

    func testInitWithDuplicateSlowExpressionWithDifferentTimes() {
        var logFile = [String]()
        logFile.append("SlowFiles.swift:36:63: warning: expression took 2010ms to type-check (limit: 100ms)")
        logFile.append("SlowFiles.swift:36:63: warning: expression took 2015ms to type-check (limit: 100ms)")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        let se = pba.getWarningController() as [SlowExpressionController]
        XCTAssertEqual(se.count, 1)
        XCTAssertEqual(se[0].getTotalWarnings(), 4025)
    }

    func testInitWithDuplicateLintWarnings() {
        var lintFile = [String]()
        lintFile.append("<td>Example/SlowFiles.swift</td>")
        lintFile.append("<td style=\"text-align: center;\">32:46</td>")
        lintFile.append("<td class=\"warning\">Warning</td>")
        lintFile.append("<td>Collection literals should not have trailing commas.</td>")
        lintFile.append("<td>Example/SlowFiles.swift</td>")
        lintFile.append("<td style=\"text-align: center;\">32:46</td>")
        lintFile.append("<td class=\"warning\">Warning</td>")
        lintFile.append("<td>Collection literals should not have trailing commas.</td>")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: lintFile, ignorePaths: [])
        let se = pba.getWarningController() as [LintWarningController]
        XCTAssertEqual(se.count, 1)
        XCTAssertEqual(se[0].getTotalWarnings(), 2)
    }

    func testGetWarningControllerNoWarnings() {
        let args = Arguments(
            repoURL: "repo",
            branch: "branch",
            outputFolder: "output",
            logFileName: "log",
            baseURLPath: "base",
            lintFileName: nil,
            buildTimeThresholdInMS: 100,
            ignorePaths: []
        )
        let pba = PostBuildAnalyzer(args: args)
        XCTAssertTrue((pba.getWarningController() as [FileWarningController]).isEmpty)
        XCTAssertTrue((pba.getWarningController() as [LinkerWarningController]).isEmpty)
        XCTAssertTrue((pba.getWarningController() as [SlowExpressionController]).isEmpty)
        XCTAssertTrue(pba.rows.isEmpty)
    }

    func testGetWarningControllerWithWarnings() {
        let args = Arguments(
            repoURL: "repo",
            branch: "master",
            outputFolder: EXAMPLE_LOG_FOLDER,
            logFileName: EXAMPLE_LOG_FILE_NAME,
            baseURLPath: "base",
            lintFileName: nil,
            buildTimeThresholdInMS: 100,
            ignorePaths: []
        )
        let pba = PostBuildAnalyzer(args: args)
        XCTAssertFalse((pba.getWarningController() as [FileWarningController]).isEmpty)
        XCTAssertFalse((pba.getWarningController() as [LinkerWarningController]).isEmpty)
        XCTAssertFalse((pba.getWarningController() as [SlowExpressionController]).isEmpty)
        XCTAssertFalse(pba.rows.isEmpty)
    }
}
