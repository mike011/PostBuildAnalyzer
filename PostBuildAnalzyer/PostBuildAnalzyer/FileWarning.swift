//
//  FileWarning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class FileWarning: Warning {

    static var lookFor = ": warning: "

    /// The file in which the error occurred
    var file = ""

    /// The line number on which the error occurred
    var lineNumber = 0

    /// The spot on the line where the error occurred
    var indent = 0

    /// A description of why the error occurred
    var description: String

    /// The line in which the error occurred
    var details = [String]()

    /// How many times the error occurred
    var count: Int = 1

    init(repoName: String, firstLine: String) {

        if let regex = try? NSRegularExpression(pattern: ":\\d+:\\d+" + FileWarning.lookFor) {
            guard regex.matches(firstLine) else {
                description = firstLine
                return
            }
        }

        var line = firstLine
        var end = line.firstIndex(of: ":")!
        file = String(line[..<end]).trimmingCharacters(in: .whitespacesAndNewlines)
        if file.contains(repoName) {
            let range = file.range(of: repoName + "/")!
            file = String(file[range.upperBound...])
        }

        var start = line.index(end, offsetBy: 1)
        line = String(line[start...])
        end = line.firstIndex(of: ":")!
        lineNumber = Int(String(line[..<end]))!

        start = line.index(end, offsetBy: 1)
        line = String(line[start...])
        end = line.firstIndex(of: ":")!
        indent = Int(String(line[..<end]))!

        start = line.index(end, offsetBy: 1)
        line = String(line[start...])
        end = line.firstIndex(of: ":")!
        start = line.index(end, offsetBy: 1)
        description = String(line[start...]).trimSpaces()
        count = 1
    }

    func add(line: String) {
        let trimmed = line.trimSpaces()
        if !trimmed.contains("^") {
            details.append(trimmed)
        }
    }

    func getFirstColumn() -> String {
        return "⚠️"
    }

    func getSecondColumn() -> String {
        var col2 = "File: \(file)<br>"
        col2 += "Line: \(lineNumber)\tWarning: \(description)<br>"
        for detail in details {
            col2 += detail + "<br>"
        }
        return String(col2.dropLast("<br>".count))
    }

    func getThirdColumn() -> String {
        return "\(count) times"
    }
}
