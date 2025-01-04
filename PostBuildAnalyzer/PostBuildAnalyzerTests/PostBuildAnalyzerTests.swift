//
//  PostBuildAnalyzerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-31.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct PostBuildAnalyzerTests {
    @Test func initNoWarnings() {
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
        #expect(pba.allWarnings.isEmpty)
    }

    @Test func initWarnings() {
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
        #expect(!pba.allWarnings.isEmpty)
    }

    @Test func initWithDuplicateWarnings() {
        var logFile = [String]()
        logFile.append("AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append("AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        let se = pba.getWarningController() as [WarningController]
        #expect(se.count == 1)
        #expect(se[0].getTotalWarnings() == 2)
    }
    
    @Test func initWithIgnoredLocation() {
        var logFile = [String]()
        logFile.append("Pods/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: ["Pods"])
        let se = pba.getWarningController() as [WarningController]
        #expect(se.count == 0)
    }

    @Test func initWithDuplicateSlowExpression() {
        var logFile = [String]()
        logFile.append("41.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()")
        logFile.append("31.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        let se = pba.getWarningController() as [SlowExpressionController]
        #expect(se.count == 1)
        #expect(se[0].getTotalWarnings() == 72.76)
    }

    @Test func initWithDuplicateSlowExpressionWithDifferentTimes() {
        var logFile = [String]()
        logFile.append("SlowFiles.swift:36:63: warning: expression took 2010ms to type-check (limit: 100ms)")
        logFile.append("SlowFiles.swift:36:63: warning: expression took 2015ms to type-check (limit: 100ms)")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        let se = pba.getWarningController() as [SlowExpressionController]
        #expect(se.count == 1)
        #expect(se[0].getTotalWarnings() == 4025)
    }

    @Test func initWithDuplicateLintWarnings() {
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
        #expect(se.count == 1)
        #expect(se[0].getTotalWarnings() == 2)
    }

    @Test func getWarningControllerNoWarnings() {
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
        #expect((pba.getWarningController() as [FileWarningController]).isEmpty)
        #expect((pba.getWarningController() as [LinkerWarningController]).isEmpty)
        #expect((pba.getWarningController() as [SlowExpressionController]).isEmpty)
        #expect(pba.rows.isEmpty)
    }

    @Test func getWarningControllerWithWarnings() {
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
        #expect(!(pba.getWarningController() as [FileWarningController]).isEmpty)
        #expect(!(pba.getWarningController() as [LinkerWarningController]).isEmpty)
        #expect(!(pba.getWarningController() as [SlowExpressionController]).isEmpty)
        #expect(!pba.rows.isEmpty)
    }
}
