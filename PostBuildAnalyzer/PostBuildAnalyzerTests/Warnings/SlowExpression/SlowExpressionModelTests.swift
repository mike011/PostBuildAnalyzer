//
//  SlowExpressionModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionModelTests: XCTestCase {
    func testCount() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10\tinstance method secondWarning()")

        XCTAssertEqual(slowExpression.count, 1)
    }

    func testTimeInMS() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10\tinstance method secondWarning()")

        XCTAssertEqual(slowExpression.timeInMS, 0.94)
    }

    func testFile() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10\tinstance method secondWarning()")

        XCTAssertEqual(slowExpression.file, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift")
    }

    func testFileWithSpaces() {
        let slowExpression = SlowExpressionModel(repoURL: "http://w.a/Frank", branch: "master", line: "243.89ms\t    /Users/distiller/project/application/Frank/Frank/Features/Authentication New/Login Flow/WelcomeView.swift:108:18\tinstance method transitionGetStartedPageViews()")
        XCTAssertNotNil(slowExpression.url)
        XCTAssertEqual(slowExpression.url.absoluteString, "http://w.a/Frank/blob/master/Frank/Features/Authentication%20New/Login%20Flow/WelcomeView.swift#L108")
    }

    func testDescription() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10\tinstance method secondWarning()")

        XCTAssertEqual(slowExpression.description, "instance method secondWarning()")
    }

    func testWarningFormat() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: "Serializer.swift:98:63: warning: expression took 108ms to type-check (limit: 100ms)")

        XCTAssertEqual(slowExpression.count, 1)
    }
}
