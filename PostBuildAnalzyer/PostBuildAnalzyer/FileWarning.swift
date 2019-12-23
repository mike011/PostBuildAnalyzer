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
    let symbol = "⚠️"

    /// The line that is being parsed.
    let line: String

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
    var count = 1

    init(repoName: String, firstLine: String) {
        self.line = firstLine
        if let regex = try? NSRegularExpression(pattern: ":\\d+:\\d+" + FileWarning.lookFor) {
            guard regex.matches(firstLine) else {
                self.description = firstLine
                return
            }
        }

        var line = firstLine
        var end = line.firstIndex(of: ":")!
        self.file = String(line[..<end]).trimmingCharacters(in: .whitespacesAndNewlines)
        if file.contains(repoName) {
            let range = file.range(of: repoName + "/")!
            self.file = String(file[range.upperBound...])
        }

        var start = line.index(end, offsetBy: 1)
        line = String(line[start...])
        end = line.firstIndex(of: ":")!
        self.lineNumber = Int(String(line[..<end]))!

        start = line.index(end, offsetBy: 1)
        line = String(line[start...])
        end = line.firstIndex(of: ":")!
        self.indent = Int(String(line[..<end]))!

        start = line.index(end, offsetBy: 1)
        line = String(line[start...])
        end = line.firstIndex(of: ":")!
        start = line.index(end, offsetBy: 1)
        self.description = String(line[start...]).trimSpaces()
        self.count = 1
    }

    func add(line: String) {
        let trimmed = line.trimSpaces()
        if !trimmed.contains("^") {
            details.append(trimmed)
        }
    }

    func getURL() -> String {
        let branch = "master"
        let repo = "https://github.com/mike011/PostBuildAnalyzer"
        return "\(repo)/blob/\(branch)/\(file)#L\(lineNumber)"
    }

    func getFilename() -> String {
        if let start = file.lastIndex(of: "/") {
            return String(file[start...].dropFirst())
        }
        return file
    }

    func getAHREF() -> String {
        return "<a href=\"\(getURL())\">\(getFilename())</a>"
    }

    var detaledDescripiton: String {
        return "\(getAHREF()) on line \(lineNumber)<br><i>\(description)</i>"
    }

    var measuredValue: String {
        return "\(count) times"
    }
}
