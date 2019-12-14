//
//  CoverageCompareTests.swift
//  CodeCoverageFrameworkTests
//
//  Created by Michael Charland on 2019-11-15.
//  Copyright © 2019 charland. All rights reserved.
//

import XCTest

class CoverageCompareTests: XCTestCase {

    // MARK: - Single File Covered

    func testCoverageAdded() {
        let before = createProject(coverage: 0.3)
        let after = createProject(coverage: 0.5)

        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())

        let rows = cc.getFilesChanged()
        XCTAssertFalse(rows.isEmpty)
        XCTAssertEqual(rows.count, 1)
        XCTAssertEqual(rows.first!.sourceFile, "name")
        XCTAssertEqual(rows.first!.beforeCoverage, 0.3)
        XCTAssertEqual(rows.first!.afterCoverage, 0.5)
        XCTAssertFalse(rows.first!.test)
    }

    func createProject(coverage: Double) -> Project {
        var files = [File]()
        files.append(File(coveredLines: 0, lineCoverage: coverage, path: "", functions: [Function](), name: "name", executableLines: 0))
        var targets = [Target]()
        targets.append(Target(coveredLines: 0, lineCoverage: 0, files: files, name: "", executableLines: 0, buildProductPath: ""))
        return Project(coveredLines: 0, lineCoverage: 0, targets: targets, executableLines: 0)
    }

    // MARK: - Multiple files

    func testCoverageAddedForMultipleFiles() {
        let before = createProjectWithMultipleFiles(coverageA: 0.2, coverageB: 0.9)
        let after = createProjectWithMultipleFiles(coverageA: 0.1, coverageB: 0.92)

        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())

        let rows = cc.getFilesChanged()

        XCTAssertFalse(rows.isEmpty)
        XCTAssertEqual(rows.count, 2)

        XCTAssertEqual(rows[0].sourceFile, "name")
        XCTAssertEqual(rows[0].beforeCoverage, 0.2)
        XCTAssertEqual(rows[0].afterCoverage, 0.1)
        XCTAssertFalse(rows[0].test)

        XCTAssertEqual(rows[1].sourceFile, "name2")
        XCTAssertEqual(rows[1].beforeCoverage, 0.9)
        XCTAssertEqual(rows[1].afterCoverage, 0.92)
        XCTAssertFalse(rows[1].test)
    }

    func createProjectWithMultipleFiles(coverageA: Double, coverageB: Double) -> Project {
        var files = [File]()
        files.append(File(coveredLines: 0, lineCoverage: coverageA, path: "", functions: [Function](), name: "name", executableLines: 0))
        files.append(File(coveredLines: 0, lineCoverage: coverageB, path: "", functions: [Function](), name: "name2", executableLines: 0))
        var targets = [Target]()
        targets.append(Target(coveredLines: 0, lineCoverage: 0, files: files, name: "", executableLines: 0, buildProductPath: ""))
        return Project(coveredLines: 0, lineCoverage: 0, targets: targets, executableLines: 0)
    }

    // MARK: - Different Targets with Coverage

    func testCoverageAddedToSeperateTarget() {
        let before = createProjectWithTargets(nameA: "name", coverageA: 0.23, nameB: "testName", coverageB: 0.92)
        let after = createProjectWithTargets(nameA: "name", coverageA: 0.22, nameB: "testName", coverageB: 0.91)

        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())

        let rows = cc.getFilesChanged()

        XCTAssertFalse(rows.isEmpty)
        XCTAssertEqual(rows.count, 2)

        XCTAssertEqual(rows[0].sourceFile, "name")
        XCTAssertEqual(rows[0].beforeCoverage, 0.23)
        XCTAssertEqual(rows[0].afterCoverage, 0.22)
        XCTAssertFalse(rows[0].test)

        XCTAssertEqual(rows[1].sourceFile, "testName")
        XCTAssertEqual(rows[1].beforeCoverage, 0.92)
        XCTAssertEqual(rows[1].afterCoverage, 0.91)
        XCTAssertFalse(rows[1].test)
    }

    func testCoverageAddedToSeperateTargetFlip() {
        let before = createProjectWithTargets(nameA: "name", coverageA: 0.23, nameB: "testName", coverageB: 0.92)
        let after = createProjectWithTargets(nameA: "testName", coverageA: 0.22, nameB: "name", coverageB: 0.91)

        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())

        let rows = cc.getFilesChanged()

        XCTAssertFalse(rows.isEmpty)
        XCTAssertEqual(rows.count, 2)

        XCTAssertEqual(rows[0].sourceFile, "name")
        XCTAssertEqual(rows[0].beforeCoverage, 0.23)
        XCTAssertEqual(rows[0].afterCoverage, 0.91)
        XCTAssertFalse(rows[0].test)

        XCTAssertEqual(rows[1].sourceFile, "testName")
        XCTAssertEqual(rows[1].beforeCoverage, 0.92)
        XCTAssertEqual(rows[1].afterCoverage, 0.22)
        XCTAssertFalse(rows[1].test)
    }

    func createProjectWithTargets(nameA: String, coverageA: Double, pathA: String = "", nameB: String, coverageB: Double) -> Project {
        let file = File(coveredLines: 0, lineCoverage: coverageA, path: pathA, functions: [Function](), name: nameA, executableLines: 0)
        var files = [File]()
        files.append(file)
        let target = Target(coveredLines: 0, lineCoverage: 0, files: files, name: "", executableLines: 0, buildProductPath: "")

        let testFile = File(coveredLines: 0, lineCoverage: coverageB, path: "", functions: [Function](), name: nameB, executableLines: 0)
        var testFiles = [File]()
        testFiles.append(testFile)
        let testTarget = Target(coveredLines: 0, lineCoverage: 0, files: testFiles, name: "", executableLines: 0, buildProductPath: "")

        var targets = [Target]()
        targets.append(target)
        targets.append(testTarget)
        return Project(coveredLines: 0, lineCoverage: 0, targets: targets, executableLines: 0)
    }

    // Mark: - File list not covered

    func testGetCoverageFileNotCovered() {
        let before = createProjectWithTargets(nameA: "name", coverageA: 0.23, pathA: "folder/name", nameB: "testName", coverageB: 0.92)
        let after = createProjectWithTargets(nameA: "testName", coverageA: 0.22, nameB: "name", coverageB: 0.91)

        var files = [String]()
        files.append("folder/name")
        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: files)

        let rows = cc.getFilesChanged()

        XCTAssertFalse(rows.isEmpty)
        XCTAssertEqual(rows.count, 1)

        XCTAssertEqual(rows[0].sourceFile, "name")
        XCTAssertEqual(rows[0].beforeCoverage, 0.23)
        XCTAssertEqual(rows[0].afterCoverage, 0.91)
        XCTAssertFalse(rows[0].test)
    }

    func testCreateTableNoRow() {
        let before = createProjectWithTargets(nameA: "name", coverageA: 0.23, pathA: "folder/name", nameB: "testName", coverageB: 0.92)
        let after = createProjectWithTargets(nameA: "testName", coverageA: 0.22, nameB: "name", coverageB: 0.91)

        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())
        let result = cc.createTable(rows: [Row](), devLink: "", prLink: "")
        XCTAssertTrue(result.isEmpty)
    }

    func testCreateTableRows() {
        let before = createProjectWithTargets(nameA: "name", coverageA: 0.23, pathA: "folder/name", nameB: "testName", coverageB: 0.92)
        let after = createProjectWithTargets(nameA: "testName", coverageA: 0.22, nameB: "name", coverageB: 0.91)

        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())
        var rows = [Row]()
        rows.append(Row(sourceFile: "source", beforeCoverage: 0.1, afterCoverage: 0.2))

        // When
        let result = cc.createTable(rows: rows, devLink: "", prLink: "a.b/s")

        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0],  "|Change|File|Develop|PR|")
        XCTAssertEqual(result[1],  "|:----:|----|:-----:|:--:|")
        XCTAssertEqual(result[2],  "|👍|<a href=a.b/source_comparison.html>source</a>|10%|20%|")
    }

    func testCreateTableRowsForTests() {
        let before = createProjectWithTargets(nameA: "", coverageA: 0, pathA: "", nameB: "", coverageB: 0.92)
        let after = createProjectWithTargets(nameA: "", coverageA: 0, nameB: "", coverageB: 0.91)

        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())
        var rows = [Row]()
        rows.append(Row(sourceFile: "sourceTest", beforeCoverage: 0.1, afterCoverage: 0.2))

        // When
        let result = cc.createTable(rows: rows, devLink: "", prLink: "http://a.b/s/")

        // THen
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0],  "|Change|File|Develop|PR|")
        XCTAssertEqual(result[1],  "|:----:|----|:-----:|:--:|")
        XCTAssertEqual(result[2],  "|👍|<a href=http://a.b/sourceTest_comparison.html>sourceTest</a>|10%|20%|")
    }

    func testCreateTableRowsForMultipleFiles() {
        let before = createProjectWithTargets(nameA: "", coverageA: 0, pathA: "", nameB: "", coverageB: 0.92)
        let after = createProjectWithTargets(nameA: "", coverageA: 0, nameB: "", coverageB: 0.91)

        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())
        var rows = [Row]()
        rows.append(Row(sourceFile: "sourceB", beforeCoverage: 0.1, afterCoverage: 0.2))
        rows.append(Row(sourceFile: "sourceA", beforeCoverage: 0.3, afterCoverage: 0.25))

        // When
        let result = cc.createTable(rows: rows, devLink: "", prLink: "http://www.github.com/mike011/ccc/slather")

        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 4)
        XCTAssertEqual(result[0],  "|Change|File|Develop|PR|")
        XCTAssertEqual(result[1],  "|:----:|----|:-----:|:--:|")
        XCTAssertEqual(result[2],  "|👎|<a href=http://www.github.com/mike011/ccc/sourceA_comparison.html>sourceA</a>|30%|25%|")
        XCTAssertEqual(result[3],  "|👍|<a href=http://www.github.com/mike011/ccc/sourceB_comparison.html>sourceB</a>|10%|20%|")
    }

    func testCreateTableRowsForMultipleTestFiles() {
        let before = createProjectWithTargets(nameA: "", coverageA: 0, pathA: "", nameB: "", coverageB: 0.92)
        let after = createProjectWithTargets(nameA: "", coverageA: 0, nameB: "", coverageB: 0.91)

        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())
        var rows = [Row]()
        rows.append(Row(sourceFile: "sourceTestB", beforeCoverage: 0.1, afterCoverage: 0.2))
        rows.append(Row(sourceFile: "sourceTestA", beforeCoverage: 0.3, afterCoverage: 0.25))

        // When
        let result = cc.createTable(rows: rows, devLink: "", prLink: "a.b/s")

        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 4)
        XCTAssertEqual(result[0],  "|Change|File|Develop|PR|")
        XCTAssertEqual(result[1],  "|:----:|----|:-----:|:--:|")
        XCTAssertEqual(result[2],  "|👎|<a href=a.b/sourceTestA_comparison.html>sourceTestA</a>|30%|25%|")
        XCTAssertEqual(result[3],  "|👍|<a href=a.b/sourceTestB_comparison.html>sourceTestB</a>|10%|20%|")
    }
}
