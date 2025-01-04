//
//  SlowExpressionViewTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct SlowExpressionViewTests {
    @Test func symbol() {
        let warning = SlowExpressionView()
        #expect(warning.symbol == "⏱")
    }

    @Test func detailedDescription() {
        let warning = SlowExpressionView()
        let model = SlowExpressionModel(repoURL: "http://w.a/repo", branch: "b", line: "0.01ms\t /Users/michael/Documents/git/repo/example/Before/Example/ExistingClassCovered.swift:11:7\tmethod initializer init()")
        let ahref = "<a href=\"http://w.a/repo/blob/b/example/Before/Example/ExistingClassCovered.swift#L11\">ExistingClassCovered.swift</a>"
        #expect(warning.getDetailedDescription(model: model) == "\(ahref) on line 11 method initializer init()")
    }

    @Test func measuredValue() {
        let warning = SlowExpressionView()
        let model = SlowExpressionModel(repoURL: "", branch: "", line: "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:11:7\tinitializer init()")
        #expect(warning.getMeasuredValue(model: model) == "0.94ms")
    }

    @Test func measuredValueFormatted() {
        let warning = SlowExpressionView()
        let model = SlowExpressionModel(repoURL: "", branch: "", line: "0.99ms\ta\tb")
        model.timeInMS = 0.3242343232232
        #expect(warning.getMeasuredValue(model: model) == "0.32ms")
    }
}
