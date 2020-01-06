//
//  PostBuildComparisonTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class PostBuildComparisonTests: XCTestCase {
    private let defaultRowsForNewTable = 4
    private let defaultRowsForTotalTable = 4
    private let grandTotalRow = 1

    // MARK: - init

    func testInit() {
        let pbc = PostBuildComparsion(before: MOCK_ARGUMENTS, after: MOCK_ARGUMENTS)
        XCTAssertNotNil(pbc)
    }

    // MARK: - getNewWarningsTable

    func testGetNewWarningsTableWithAWarning() {
        let before = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String]())

        var logFile = [String]()
        logFile.append(": warning: ")
        let after = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)

        let pbc = PostBuildComparsion(before: before, after: after, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: "~/Users/dev/git/project/fastlane/test_output")
        XCTAssertFalse(pbc.getNewWarningsTable().isEmpty)
        XCTAssertEqual(pbc.getNewWarningsTable().count, defaultRowsForNewTable + 1)
    }

    func testGetNewWarningsTableMultipleWarnings() {
        let before = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String]())

        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append(": warning: 2")
        let after = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)

        let pbc = PostBuildComparsion(before: before, after: after, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: "~/Users/dev/git/project/fastlane/test_output")
        XCTAssertFalse(pbc.getNewWarningsTable().isEmpty)
        XCTAssertEqual(pbc.getNewWarningsTable().count, defaultRowsForNewTable + 2)
    }

    func testGetNewWarningsTableNoWarnings() {
        let before = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String]())
        let after = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String]())

        let pbc = PostBuildComparsion(before: before, after: after, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: "~/Users/dev/git/project/fastlane/test_output")
        XCTAssertTrue(pbc.getNewWarningsTable().isEmpty)
    }

    // MARK: - getTotalWarningsTable

    func testGetTotalWarningsTableAllWarnings() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)

        let pbc = PostBuildComparsion(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: "~/Users/dev/git/project/fastlane/test_output/")
        XCTAssertFalse(pbc.getTotalWarningsTable().isEmpty)
        XCTAssertEqual(pbc.getTotalWarningsTable().count, defaultRowsForTotalTable + grandTotalRow + 3)
    }

    func testGetTotalWarningsTableNoWarnings() {
        let pba = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String]())
        let pbc = PostBuildComparsion(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: "~/Users/dev/git/project/fastlane/test_output")
        XCTAssertTrue(pbc.getTotalWarningsTable().isEmpty)
    }

    // MARK: - getTotalWarningsTable - slow expressions

    func testGetTotalWarningsTableOnlySlowExpressions() {
        var logFile = [String]()
        logFile.append("2.55ms\tfilet\tmethod")
        let pba = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)

        let pbc = PostBuildComparsion(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: "~/Users/dev/git/project/fastlane/test_output")
        XCTAssertFalse(pbc.getTotalWarningsTable().isEmpty)
        XCTAssertEqual(pbc.getTotalWarningsTable().count, defaultRowsForTotalTable + grandTotalRow + 1)
    }

    // MARK: - getTotalWarningsTable - file warnings

    func testGetTotalWarningsTableOnlyFileWarnings() {
        var logFile = [String]()
        logFile.append(": warning: ")
        let pba = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)

        let pbc = PostBuildComparsion(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: "~/Users/dev/git/project/fastlane/test_output")
        XCTAssertFalse(pbc.getTotalWarningsTable().isEmpty)
        XCTAssertEqual(pbc.getTotalWarningsTable().count, defaultRowsForTotalTable + grandTotalRow + 1)
    }

    // MARK: - getTotalWarningsTable - linker warnings

    func testGetTotalWarningsTableOnlyLinkerWarnings() {
        var logFile = [String]()
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)

        let pbc = PostBuildComparsion(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: "~/Users/dev/git/project/fastlane/test_output")
        XCTAssertFalse(pbc.getTotalWarningsTable().isEmpty)
        XCTAssertEqual(pbc.getTotalWarningsTable().count, defaultRowsForTotalTable + grandTotalRow + 1)
    }
}
