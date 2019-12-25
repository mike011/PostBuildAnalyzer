//
//  SlowExpression.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpression: WarningModel, Hashable, Equatable {
    // not used, used regex instead.
    static var lookFor = ""

    var line: String
    var description: String = ""
    var count: Int
    var symbol: String = "⏱"
    var detailedDescripiton: String

    var timeInMS: Double
    var file: String
    var lineNumber: Int
    var indent: Int

    var measuredValue: String {
        return "\(count) times"
    }

    init(line firstLine: String) {
        self.detailedDescripiton = firstLine
        self.line = firstLine
        self.count = 1

        if line.contains("<invalid loc>") {
            self.file = "<invalid loc>"
            self.lineNumber = -1
            self.indent = -1
            self.timeInMS = -1
        } else {
            // 0.94ms    /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10    instance method secondWarning()
            let line = firstLine
            self.timeInMS = Self.parseTimeInMS(line: line)
//            var end = line.firstIndex(of: " ")!

            self.file = ""
            self.lineNumber = -1
            self.indent = -1

            self.detailedDescripiton = line
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

    static func parseTimeInMS(line: String) -> Double {
        let start = line.firstIndex(of: "m")!
        let time = String(line[..<start])
        return Double(time) ?? 0.0
    }

    static func == (lhs: SlowExpression, rhs: SlowExpression) -> Bool {
        return lhs.line == rhs.line
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(line)
    }
}

extension PostBuildAnalzyer {
    static func isSlowExpression(line: String, minimumTimeInMS: Double) -> Bool {
        if let regex = try? NSRegularExpression(pattern: "\\d+\\.\\d{2}ms" + SlowExpression.lookFor) {
            return regex.matches(line) && SlowExpression.parseTimeInMS(line: line) > minimumTimeInMS && !line.contains("invalid loc")
        }
        return false
    }
}
