//
//  SlowExpression.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpression: Warning {
    // not used, used regex instead.
    static var lookFor = ""

    var line: String
    var description: String = ""
    var count: Int
    var symbol: String = "⏱"
    var detailedDescripiton: String = ""

    var timeInMS: Double
    var file: String
    var lineNumber: Int
    var indent: Int

    var measuredValue: String {
        return "\(count) times"
    }

    init(line firstLine: String) {
        self.line = firstLine
        self.count = 1

        if line.contains("<invalid loc>") {
            self.file = "<invalid loc>"
            self.lineNumber = -1
            self.indent = -1
            self.timeInMS = -1
        } else {
            // 0.94ms    /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10    instance method secondWarning()
            var line = firstLine
            var start = line.firstIndex(of: "m")!
            let time = String(line[..<start])
            self.timeInMS = Double(time) ?? 0.0
//            var end = line.firstIndex(of: " ")!

            self.file = ""
            self.lineNumber = -1
            self.indent = -1
//
//            self.file = String(line[start..<end]).trimmingCharacters(in: .whitespacesAndNewlines)
//            start = line.index(end, offsetBy: 1)
//            line = String(line[start...])
//            end = line.firstIndex(of: ":")!
//            self.lineNumber = Int(String(line[..<end]))!
//
//            start = line.index(end, offsetBy: 1)
//            line = String(line[start...])
//            end = line.firstIndex(of: ":")!
//            self.indent = Int(String(line[..<end]))!
//
//            start = line.index(end, offsetBy: 1)
//            line = String(line[start...])
//            end = line.firstIndex(of: ":")!
//            start = line.index(end, offsetBy: 1)
//            self.description = String(line[start...]).trimSpaces()
        }
    }
}
