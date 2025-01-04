//
//  URLParserTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation
import Testing

class TestParser: URLParser {}

@Suite struct URLParserTests {
    @Test func getURLRealLifeExample() {
        let line = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift"
        let url = TestParser.getURL(file: line, lineNumber: 15, repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master")
        #expect(url == URL(string: "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15"))
    }

    @Test func getRepoPath() {
        #expect(TestParser.getRepoName(fromRepoURL: "NO_SLASHES") == "NO_SLASHES")
        #expect(TestParser.getRepoName(fromRepoURL: "a/b/c") == "c")
    }

    @Test func getPath() {
        #expect(TestParser.getPath(file: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift", repoName: "PostBuildAnalyzer") == "example/Before/Example/ExistingClassCovered.swift")
    }

    @Test func getPathCircle() {
        #expect(TestParser.getPath(file: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift", repoName: "") == "example/Before/Example/ExistingClassCovered.swift")
    }
    
    @Test func getPathBitrise() {
        #expect(TestParser.getPath(file: "/Users/vagrant/git/example/Before/Example/ExistingClassCovered.swift", repoName: "") == "example/Before/Example/ExistingClassCovered.swift")
    }
    
    @Test func getPathCodemagic() {
        #expect(TestParser.getPath(file: "/Users/builder/clone/example/Before/Example/ExistingClassCovered.swift", repoName: "") == "example/Before/Example/ExistingClassCovered.swift")
    }

    @Test func getPathNotParsedInvalidFolder() {
        let line = "/Users/project/example/Before/Example/ExistingClassCovered.swift"
        let url = TestParser.getPath(file: line, repoName: "")
        #expect(url == line)
    }

    @Test func getPathNotParsedNoColon() {
        let line = "/Users/project/example/Before/Example/ExistingClassCovered.swift"
        let url = TestParser.getPath(file: line, repoName: "")
        #expect(url == line)
    }

    @Test func getLineNumber() {
        #expect(TestParser.getLineNumber(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:11") == 15)
    }

    @Test func getLineNumberNoStartColon() {
        #expect(TestParser.getLineNumber(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift") == nil)
    }

    @Test func getLineNumberNoEndColon() {
        #expect(TestParser.getLineNumber(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1") == nil)
    }
}
