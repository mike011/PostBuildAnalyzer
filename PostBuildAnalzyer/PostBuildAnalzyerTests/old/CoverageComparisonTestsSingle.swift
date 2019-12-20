////
////  CoverageComparisonTests.swift
////  CodeCoverageFrameworkTests
////
////  Created by Michael Charland on 2019-11-15.
////  Copyright © 2019 charland. All rights reserved.
////
//
//import XCTest
//
///// Makes sure reading the coverage for the before and after arguments works expected
//class CoverageComparisonSingleTests: XCTestCase {
//
//    // MARK: - No Coverage
//
//    func testNoCoverage() {
//        let before = Project(coveredLines: 0, lineCoverage: 0, targets: [Target](), executableLines: 0)
//        let after = Project(coveredLines: 0, lineCoverage: 0, targets: [Target](), executableLines: 0)
//        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())
//        let rows = cc.getFilesChanged()
//        XCTAssertTrue(rows.isEmpty)
//    }
//
//    // MARK: - Single File Covered
//
//    func testCoverageAdded() {
//        let before = Project(coveredLines: 0, lineCoverage: 0, targets: [Target](), executableLines: 0)
//        let after = createProject()
//
//        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""), before: before, after: after, fileList: [String]())
//
//        let rows = cc.getFilesChanged()
//        XCTAssertFalse(rows.isEmpty)
//        XCTAssertEqual(rows.count, 1)
//        XCTAssertEqual(rows.first!.sourceFile, "name")
//        XCTAssertNil(rows.first!.beforeCoverage)
//        XCTAssertEqual(rows.first!.afterCoverage, 1.0)
//        XCTAssertFalse(rows.first!.test)
//    }
//
//    func testCoverageRemoved() {
//        let before = createProject()
//        let after = Project(coveredLines: 0, lineCoverage: 0, targets: [Target](), executableLines: 0)
//
//        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""),before: before, after: after, fileList: [String]())
//        
//        let rows = cc.getFilesChanged()
//        XCTAssertFalse(rows.isEmpty)
//        XCTAssertEqual(rows.count, 1)
//        XCTAssertEqual(rows.first!.sourceFile, "name")
//        XCTAssertEqual(rows.first!.beforeCoverage, 1.0)
//        XCTAssertNil(rows.first!.afterCoverage)
//        XCTAssertFalse(rows.first!.test)
//    }
//
//    func createProject() -> Project {
//        var files = [File]()
//        files.append(File(coveredLines: 0, lineCoverage: 1.0, path: "path", functions: [Function](), name: "name", executableLines: 0))
//        var targets = [Target]()
//        targets.append(Target(coveredLines: 0, lineCoverage: 0, files: files, name: "", executableLines: 0, buildProductPath: ""))
//        return Project(coveredLines: 0, lineCoverage: 0, targets: targets, executableLines: 0)
//    }
//
//    // MARK: - Multiple files
//
//    func testCoverageAddedForMultipleFiles() {
//        let before = Project(coveredLines: 0, lineCoverage: 0, targets: [Target](), executableLines: 0)
//        let after = createProjectWithMultipleFiles()
//
//        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""),before: before, after: after, fileList: [String]())
//
//        let rows = cc.getFilesChanged()
//
//        XCTAssertFalse(rows.isEmpty)
//        XCTAssertEqual(rows.count, 2)
//
//        XCTAssertEqual(rows[0].sourceFile, "name")
//        XCTAssertNil(rows[0].beforeCoverage)
//        XCTAssertEqual(rows[0].afterCoverage, 1.0)
//        XCTAssertFalse(rows[0].test)
//
//        XCTAssertEqual(rows[1].sourceFile, "name2")
//        XCTAssertNil(rows[1].beforeCoverage)
//        XCTAssertEqual(rows[1].afterCoverage, 0.5)
//        XCTAssertFalse(rows[1].test)
//    }
//
//    func testCoverageRemovedForMultipleFiles() {
//        let before = createProjectWithMultipleFiles()
//        let after = Project(coveredLines: 0, lineCoverage: 0, targets: [Target](), executableLines: 0)
//
//        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""),before: before, after: after, fileList: [String]())
//
//        let rows = Array(cc.getFilesChanged())
//        
//        XCTAssertFalse(rows.isEmpty)
//        XCTAssertEqual(rows.count, 2)
//
//        XCTAssertEqual(rows[0].sourceFile, "name")
//        XCTAssertEqual(rows[0].beforeCoverage, 1.0)
//        XCTAssertNil(rows[0].afterCoverage)
//        XCTAssertFalse(rows[0].test)
//
//        XCTAssertEqual(rows[1].sourceFile, "name2")
//        XCTAssertEqual(rows[1].beforeCoverage, 0.5)
//        XCTAssertNil(rows[1].afterCoverage)
//        XCTAssertFalse(rows[1].test)
//    }
//
//    func createProjectWithMultipleFiles() -> Project {
//        var files = [File]()
//        files.append(File(coveredLines: 0, lineCoverage: 1.0, path: "", functions: [Function](), name: "name", executableLines: 0))
//        files.append(File(coveredLines: 0, lineCoverage: 0.5, path: "", functions: [Function](), name: "name2", executableLines: 0))
//        var targets = [Target]()
//        targets.append(Target(coveredLines: 0, lineCoverage: 0, files: files, name: "", executableLines: 0, buildProductPath: ""))
//        return Project(coveredLines: 0, lineCoverage: 0, targets: targets, executableLines: 0)
//    }
//
//    // MARK: - Different Targets with Coverage
//
//    func testCoverageAddedToSeperateTarget() {
//        let before = Project(coveredLines: 0, lineCoverage: 0, targets: [Target](), executableLines: 0)
//        let after = createProjectWithTargets()
//
//        let cc = CoverageComparison(writeLocation: URL(fileURLWithPath: ""),before: before, after: after, fileList: [String]())
//
//        let rows = cc.getFilesChanged()
//
//        XCTAssertFalse(rows.isEmpty)
//        XCTAssertEqual(rows.count, 2)
//
//        XCTAssertEqual(rows[0].sourceFile, "name")
//        XCTAssertNil(rows[0].beforeCoverage)
//        XCTAssertEqual(rows[0].afterCoverage, 0.6)
//        XCTAssertFalse(rows[0].test)
//
//        XCTAssertEqual(rows[1].sourceFile, "testName")
//        XCTAssertNil(rows[1].beforeCoverage)
//        XCTAssertEqual(rows[1].afterCoverage, 0.8)
//        XCTAssertFalse(rows[1].test)
//    }
//
//    func createProjectWithTargets() -> Project {
//        let file = File(coveredLines: 0, lineCoverage: 0.6, path: "", functions: [Function](), name: "name", executableLines: 0)
//        var files = [File]()
//        files.append(file)
//        let target = Target(coveredLines: 0, lineCoverage: 0, files: files, name: "", executableLines: 0, buildProductPath: "")
//
//        let testFile = File(coveredLines: 0, lineCoverage: 0.8, path: "", functions: [Function](), name: "testName", executableLines: 0)
//        var testFiles = [File]()
//        testFiles.append(testFile)
//        let testTarget = Target(coveredLines: 0, lineCoverage: 0, files: testFiles, name: "", executableLines: 0, buildProductPath: "")
//
//        var targets = [Target]()
//        targets.append(target)
//        targets.append(testTarget)
//        return Project(coveredLines: 0, lineCoverage: 0, targets: targets, executableLines: 0)
//    }
//}
