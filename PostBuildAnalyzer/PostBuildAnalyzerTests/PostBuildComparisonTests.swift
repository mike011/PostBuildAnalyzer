//
//  PostBuildComparisonTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class PostBuildComparisonTests: XCTestCase {
    private let defaultRowsForNewTable = 2
    private let defaultRowsForTotalTable = 2
    private let grandTotalRow = 1

    // MARK: - init

    func testInit() {
        let pbc = PostBuildComparison(before: MOCK_ARGUMENTS, after: MOCK_ARGUMENTS)
        XCTAssertNotNil(pbc)
    }

    /// MOST OF THE FOLLOWING TESTS NEED TO BE MOVED TO TESTING getNewWarningsTable so you can test the differnece in the rows.

    // MARK: - getNewWarningsTable

    func testGetNewWarningsTableWithAWarning() {
        let before = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])

        var logFile = [String]()
        logFile.append(": warning: ")
        let after = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: before, after: after, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let table = pbc.getNewWarningsTable()
        XCTAssertFalse(table.elements.isEmpty)
        XCTAssertEqual(pbc.getNewWarningsTable().elements.count, 3)
    }

    func testGetNewWarningsTableMultipleWarnings() {
        let before = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])

        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append(": warning: 2")
        let after = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: before, after: after, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        XCTAssertFalse(pbc.getNewWarningsTable().elements.isEmpty)
        XCTAssertEqual(pbc.getNewWarningsTable().elements.count, 3)
    }

    func testGetNewWarningsTableNoWarnings() {
        let before = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])
        let after = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: before, after: after, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        XCTAssertTrue(pbc.getNewWarningsTable().elements.isEmpty)
    }

    // MARK: - getTotalWarningsTable

    func testGetTotalWarningsTableAllWarnings() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getTotalWarningsTable().elements
        XCTAssertFalse(elements.isEmpty)
        XCTAssertEqual(elements.count, 3)
    }

    func testGetTotalWarningsTableNoWarnings() {
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])
        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        XCTAssertTrue(pbc.getTotalWarningsTable().elements.isEmpty)
    }

    // MARK: - getTotalWarningsTable - slow expressions

    func testGetTotalWarningsTableOnlySlowExpressions() {
        var logFile = [String]()
        logFile.append("2.55ms\tfilet\tmethod")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        XCTAssertFalse(pbc.getTotalWarningsTable().elements.isEmpty)
        XCTAssertEqual(pbc.getTotalWarningsTable().elements.count, 3)
    }

    // MARK: - getTotalWarningsTable - file warnings

    func testGetTotalWarningsTableOnlyFileWarnings() {
        var logFile = [String]()
        logFile.append(": warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        XCTAssertFalse(pbc.getTotalWarningsTable().elements.isEmpty)
        XCTAssertEqual(pbc.getTotalWarningsTable().elements.count, 3)
    }

    // MARK: - getTotalWarningsTable - linker warnings

    func testGetTotalWarningsTableOnlyLinkerWarnings() {
        var logFile = [String]()
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        XCTAssertFalse(pbc.getTotalWarningsTable().elements.isEmpty)
        XCTAssertEqual(pbc.getTotalWarningsTable().elements.count, 3)
    }

    // MARK: - New Warnings

    func testGetNewWarnings() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pbb = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pbb, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getNewWarnings()
        XCTAssertEqual(elements.count, 3)
    }

    func testGetNewWarningsSameAsBefore() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getNewWarnings()
        XCTAssertEqual(elements.count, 0)
    }

    func testGetNewWarningsLessWarnings() {
        var logFile = [String]()
        logFile.append(": warning: duplicate")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: not found")
        let pbb = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        var logFile2 = [String]()
        logFile2.append(": warning: duplicate")
        logFile2.append("2.55ms\tfilet\tmethod")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile2, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pbb, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getNewWarnings()
        XCTAssertEqual(elements.count, 0)
    }

    func testGetFixedWarnings() {
        var logFile = [String]()
        logFile.append(": warning: duplicate")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: not found")
        let pbb = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        var logFile2 = [String]()
        logFile2.append(": warning: duplicate")
        logFile2.append("2.55ms\tfilet\tmethod")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile2, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pbb, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getFixedWarnings()
        XCTAssertEqual(elements.count, 1)
    }

    func testGetFixedWarningsSameAsBefore() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getFixedWarnings()
        XCTAssertEqual(elements.count, 0)
    }

    func testGetFixedWarningsMoreWarnings() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        let pbb = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        var logFile2 = [String]()
        logFile2.append(": warning: ")
        logFile2.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile2, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pbb, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getFixedWarnings()
        XCTAssertEqual(elements.count, 0)
    }

    func testGetNewWarningsSlowExpression() {
        var logFile = [String]()
        logFile.append("/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:36:63: warning: expression took 2010ms to type-check (limit: 100ms)")
        let pbb = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        var logFile2 = [String]()
        logFile2.append("/Users/michael/Documents/git/PostBuildAnalyzer/example/After/Example/Warnings.swift:36:63: warning: expression took 2030ms to type-check (limit: 100ms)")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile2, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pbb, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        XCTAssertEqual(pbc.getNewWarnings().count, 0)
        XCTAssertEqual(pbc.getFixedWarnings().count, 0)

    }
}
