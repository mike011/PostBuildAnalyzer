//
//  SlowExpressionModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct SlowExpressionModelTests {
    private let timingSummary = "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10\tinstance method secondWarning()"
    private let warning = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:36:63: warning: expression took 2010ms to type-check (limit: 100ms)"

    @Test func count() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)

        #expect(slowExpression.count == 1)
    }

    @Test func countFromWarning() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: warning)
        #expect(slowExpression.count == 1)
    }

    @Test func timeInMS() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        #expect(slowExpression.timeInMS == 0.94)
    }

    @Test func timeInMSFromWarning() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: warning)
        #expect(slowExpression.timeInMS == 2010)
    }

    @Test func file() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        #expect(slowExpression.file == "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift")
    }

    @Test func fileFromWarning() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: warning)
        #expect(slowExpression.file == "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift")
    }

    @Test func fileWithSpaces() {
        let slowExpression = SlowExpressionModel(repoURL: "http://w.a/Frank", branch: "master", line: "243.89ms\t    /Users/distiller/project/application/Frank/Frank/Features/Authentication New/Login Flow/WelcomeView.swift:108:18\tinstance method transitionGetStartedPageViews()")
        #expect(slowExpression.url != nil)
        #expect(slowExpression.url.absoluteString == "http://w.a/Frank/blob/master/Frank/Features/Authentication%20New/Login%20Flow/WelcomeView.swift#L108")
    }

    @Test func description() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        #expect(slowExpression.description == "instance method secondWarning()")
    }

    @Test func descriptionFromWarning() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: warning)
        #expect(slowExpression.description == "expression took 2010ms to type-check (limit: 100ms)")
    }

    @Test func parseTimeInMS() {
        #expect(SlowExpressionModel.parseTimeInMS(line: "am") == 0)
        #expect(SlowExpressionModel.parseTimeInMS(line: "4m") == 4)
    }

    @Test func parseTimeInMSFromWarning() {
        #expect(SlowExpressionModel.parseTimeInMSFromWarning(line: "expression took 2010ms to type-check (limit: 100ms)") == 2010)
    }

    @Test func compareToSame() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        let slowExpression2 = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        #expect(slowExpression.compareTo(line: slowExpression2.line))
    }

    @Test func compareToDifferentFiles() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        let slowExpression2 = SlowExpressionModel(repoURL: "", branch: "", line: "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Envelope.swift:19:10\tinstance method secondWarning()")
        #expect(!slowExpression.compareTo(line: slowExpression2.line))
    }

    @Test func compareToDifferentLines() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: timingSummary)
        let slowExpression2 = SlowExpressionModel(repoURL: "", branch: "", line: "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Envelope.swift:18:10\tinstance method secondWarning()")
        #expect(!slowExpression.compareTo(line: slowExpression2.line))
    }

    @Test func compareToDifferentCompileTimes() {
        let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: warning)
        let slowExpression2 = SlowExpressionModel(repoURL: "", branch: "", line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:36:63: warning: expression took 2015ms to type-check (limit: 100ms)")
        #expect(slowExpression.compareTo(line: slowExpression2.line))
    }

    // Why is the file url incorrect for the slow expression file from a warning
}
