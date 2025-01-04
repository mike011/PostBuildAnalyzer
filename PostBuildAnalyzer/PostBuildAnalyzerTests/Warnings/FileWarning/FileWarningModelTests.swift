//
//  FileWarningModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct FileWarningModelTests {
    @Test func warning() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", line: description)
        #expect(warning.url?.absoluteString == "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
        #expect(warning.lineNumber == 15)
        #expect(warning.description == "'index(of:)' is deprecated: renamed to 'firstIndex(of:)'")
    }

    @Test func warningSingleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1:2: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarningModel(repoURL: "", branch: "", line: description)
        #expect(warning.lineNumber == 1)
    }

    @Test func warningTripleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:145:267: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarningModel(repoURL: "", branch: "", line: description)
        #expect(warning.lineNumber == 145)
    }

    func getSampleWarning() -> FileWarningModel {
        let warning = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", line: "Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        return warning
    }

    func getAnotherSampleWarning() -> FileWarningModel {
        let warning = FileWarningModel(repoURL: "", branch: "", line: "Documents/git/PostBuildAnalyzer/example/Before/Example/Frank.swift:16:15: warning: result of call to 'substring(to:)' is unused")
        warning.count = 2
        return warning
    }

    @Test func getFileName() {
        let warning = FileWarningModel(repoURL: "", branch: "", line: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        #expect(warning.getFilename() == "ExistingClassCovered.swift")
    }

    @Test func getURL() {
        let warning = getSampleWarning()
        #expect(warning.url?.absoluteString == "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
    }

    @Test func getURLCircleFolder() {
        let warning = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", line: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        #expect(warning.url?.absoluteString == "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
    }

    @Test func getRepo() {
        #expect(FileWarningModel.getRepoName(fromRepoURL: "junk") == "junk")
        #expect(FileWarningModel.getRepoName(fromRepoURL: "https://github.com/mike011/PostBuildAnalyzer") == "PostBuildAnalyzer")
    }

    @Test func initWithFile() {
        let warning = FileWarningModel(repoURL: "http://a.c/repo", branch: "b", line: "repo/file: warning: error")
        #expect(warning.file == "file")
        #expect(warning.url?.absoluteString == "http://a.c/repo/blob/b/file")
        #expect(warning.lineNumber == nil)
        #expect(warning.description == "error")
    }

    @Test func initWithFileWithLine() {
        let warning = FileWarningModel(repoURL: "http://a.c/repo", branch: "b", line: "repo/file:1:2: warning: error")
        #expect(warning.file == "file")
        #expect(warning.url?.absoluteString == "http://a.c/repo/blob/b/file#L1")
        #expect(warning.lineNumber == 1)
        #expect(warning.description == "error")
    }

    @Test func initWithCoreData() {
        let line = "/Users/distiller/project/application/A/A/Core Data/A.xcdatamodeld/A 6.1.4.xcdatamodel:TMOAccountInfo.premiumState: warning: error"
        let warning = FileWarningModel(repoURL: "http://a.c/A", branch: "b", line: line)
        #expect(warning.file == "A/Core Data/A.xcdatamodeld/A 6.1.4.xcdatamodel:TMOAccountInfo.premiumState")
        #expect(warning.lineNumber == nil)
        #expect(warning.description == "error")
    }
}
