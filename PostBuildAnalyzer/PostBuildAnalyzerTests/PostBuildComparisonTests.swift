//
//  PostBuildComparisonTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation
import Testing

@Suite struct PostBuildComparisonTests {
    private let defaultRowsForNewTable = 2
    private let defaultRowsForTotalTable = 2
    private let grandTotalRow = 1

    // MARK: - init

    @Test func test_init() {
        let pbc = PostBuildComparison(before: MOCK_ARGUMENTS, after: MOCK_ARGUMENTS)
        #expect(pbc != nil)
    }

    /// MOST OF THE FOLLOWING TESTS NEED TO BE MOVED TO TESTING getNewWarningsTable so you can test the difference in the rows.

    // MARK: - getNewWarningsTable

    @Test func getNewWarningsTableWithAWarning() {
        let before = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])

        var logFile = [String]()
        logFile.append(": warning: ")
        let after = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: before, after: after, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let table = pbc.getNewWarningsTable()
        #expect(!table.elements.isEmpty)
        #expect(pbc.getNewWarningsTable().elements.count == 3)
    }

    @Test func getNewWarningsTableMultipleWarnings() {
        let before = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])

        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append(": warning: 2")
        let after = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: before, after: after, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        #expect(!pbc.getNewWarningsTable().elements.isEmpty)
        #expect(pbc.getNewWarningsTable().elements.count == 3)
    }

    @Test func getNewWarningsTableNoWarnings() {
        let before = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])
        let after = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: before, after: after, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        #expect(pbc.getNewWarningsTable().elements.isEmpty)
    }

    // MARK: - getTotalWarningsTable

    @Test func getTotalWarningsTableAllWarnings() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getTotalWarningsTable().elements
        #expect(!elements.isEmpty)
        #expect(elements.count == 3)
    }

    @Test func getTotalWarningsTableNoWarnings() {
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])
        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        #expect(pbc.getTotalWarningsTable().elements.isEmpty)
    }

    // MARK: - getTotalWarningsTable - slow expressions

    @Test func getTotalWarningsTableOnlySlowExpressions() {
        var logFile = [String]()
        logFile.append("2.55ms\tfilet\tmethod")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        #expect(!pbc.getTotalWarningsTable().elements.isEmpty)
        #expect(pbc.getTotalWarningsTable().elements.count == 3)
    }

    // MARK: - getTotalWarningsTable - file warnings

    @Test func getTotalWarningsTableOnlyFileWarnings() {
        var logFile = [String]()
        logFile.append(": warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        #expect(!pbc.getTotalWarningsTable().elements.isEmpty)
        #expect(pbc.getTotalWarningsTable().elements.count == 3)
    }

    // MARK: - getTotalWarningsTable - linker warnings

    @Test func getTotalWarningsTableOnlyLinkerWarnings() {
        var logFile = [String]()
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        #expect(!pbc.getTotalWarningsTable().elements.isEmpty)
        #expect(pbc.getTotalWarningsTable().elements.count == 3)
    }

    // MARK: - New Warnings

    @Test func getNewWarnings() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pbb = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: [String](), lintFile: [String](), ignorePaths: [])
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pbb, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getNewWarnings()
        #expect(elements.count == 3)
    }

    @Test func getNewWarningsSameAsBefore() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getNewWarnings()
        #expect(elements.count == 0)
    }

    @Test func getNewWarningsLessWarnings() {
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
        #expect(elements.count == 0)
    }

    @Test func getFixedWarnings() {
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
        #expect(elements.count == 1)
    }

    @Test func getFixedWarningsSameAsBefore() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append("2.55ms\tfilet\tmethod")
        logFile.append("ld: warning: ")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pba, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        let elements = pbc.getFixedWarnings()
        #expect(elements.count == 0)
    }

    @Test func getFixedWarningsMoreWarnings() {
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
        #expect(elements.count == 0)
    }

    @Test func getNewWarningsSlowExpression() {
        var logFile = [String]()
        logFile.append("/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:36:63: warning: expression took 2010ms to type-check (limit: 100ms)")
        let pbb = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])

        var logFile2 = [String]()
        logFile2.append("/Users/michael/Documents/git/PostBuildAnalyzer/example/After/Example/Warnings.swift:36:63: warning: expression took 2030ms to type-check (limit: 100ms)")
        let pba = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile2, lintFile: [String](), ignorePaths: [])

        let pbc = PostBuildComparison(before: pbb, after: pba, baseURLPath: "http://a.b/", buildTimeThresholdInMS: 0, outputFolder: FileManager.default.temporaryDirectory.absoluteString)
        #expect(pbc.getNewWarnings().count == 0)
        #expect(pbc.getFixedWarnings().count == 0)

    }
}
