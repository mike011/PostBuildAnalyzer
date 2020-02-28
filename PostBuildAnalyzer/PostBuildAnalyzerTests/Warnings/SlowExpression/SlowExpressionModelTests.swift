//
//  SlowExpressionModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionModelTests: XCTestCase {
    private let timingSummary = "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10\tinstance method secondWarning()"
    private let warning = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:36:63: warning: expression took 2010ms to type-check (limit: 100ms)"

    func testCount() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)

        XCTAssertEqual(slowExpression.count, 1)
    }

    func testCountFromWarning() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: warning)
        XCTAssertEqual(slowExpression.count, 1)
    }

    func testTimeInMS() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        XCTAssertEqual(slowExpression.timeInMS, 0.94)
    }

    func testTimeInMSFromWarning() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: warning)
        XCTAssertEqual(slowExpression.timeInMS, 2010)
    }

    func testFile() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        XCTAssertEqual(slowExpression.file, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift")
    }

    func testFileFromWarning() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: warning)
        XCTAssertEqual(slowExpression.file, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift")
    }

    func testFileWithSpaces() {
        let slowExpression = SlowExpressionModel(repoURL: "http://w.a/Frank", branch: "master", line: "243.89ms\t    /Users/distiller/project/application/Frank/Frank/Features/Authentication New/Login Flow/WelcomeView.swift:108:18\tinstance method transitionGetStartedPageViews()")
        XCTAssertNotNil(slowExpression.url)
        XCTAssertEqual(slowExpression.url.absoluteString, "http://w.a/Frank/blob/master/Frank/Features/Authentication%20New/Login%20Flow/WelcomeView.swift#L108")
    }

    func testDescription() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        XCTAssertEqual(slowExpression.description, "instance method secondWarning()")
    }

    func testDescriptionFromWarning() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: warning)
        XCTAssertEqual(slowExpression.description, "expression took 2010ms to type-check (limit: 100ms)")
    }

    func testParseTimeInMS() {
        XCTAssertEqual(SlowExpressionModel.parseTimeInMS(line: "am"), 0)
        XCTAssertEqual(SlowExpressionModel.parseTimeInMS(line: "4m"), 4)
    }

    func testParseTimeInMSFromWarning() {
        XCTAssertEqual(SlowExpressionModel.parseTimeInMSFromWarning(line: "expression took 2010ms to type-check (limit: 100ms)"), 2010)
    }
}
