//
//  FileWarning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class FileWarning: Warning, Hashable, Equatable {
    static var lookFor = ": warning: "
    let symbol = "⚠️"

    /// The url of repository
    /// eg: https://github.com/mike011/PostBuildAnalyzer
    let repoURL: String

    /// The branch the build is on.
    /// eg: master
    let branch: String

    /// The line that is being parsed.
    let line: String

    /// The file in which the error occurred
    var file: String

    /// The line number on which the error occurred
    var lineNumber: Int

    /// The spot on the line where the error occurred
    var indent: Int

    /// A description of why the error occurred
    var description: String

    /// The line in which the error occurred
    var details = [String]()

    /// How many times the error occurred
    var count = 1

    init(repoURL: String, branch: String, firstLine: String) {
        self.repoURL = repoURL
        self.branch = branch
        self.line = firstLine
        if let regex = try? NSRegularExpression(pattern: ":\\d+:\\d+" + FileWarning.lookFor) {
            guard regex.matches(firstLine) else {
                self.description = firstLine
                self.file = ""
                self.lineNumber = -1
                self.indent = -1
                return
            }
        }

        // craate Link
        var line = firstLine
        var end = line.firstIndex(of: ":")!
        self.file = String(line[..<end]).trimmingCharacters(in: .whitespacesAndNewlines)
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

    static func getRepoName(fromRepoURL repoURL: String) -> String {
        if let range = repoURL.range(of: "/", options: .backwards) {
            return String(repoURL[range.upperBound...])
        }
        return repoURL
    }

    func add(line: String) {
        let trimmed = line.trimSpaces()
        if !trimmed.contains("^") {
            details.append(trimmed)
        }
    }

    func getURL() -> String {
        let circleFolder = "/Users/distiller/project/"
        if file.contains(Self.getRepoName(fromRepoURL: repoURL)) {
            let range = file.range(of: Self.getRepoName(fromRepoURL: repoURL) + "/")!
            file = String(file[range.upperBound...])
        } else if file.contains(circleFolder) {
            let range = file.range(of: circleFolder)!
            file = String(file[range.upperBound...])
        }
        return "\(repoURL)/blob/\(branch)/\(file)#L\(lineNumber)"
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

    var detailedDescripiton: String {
        if file.isEmpty {
            return description
        } else {
            return "\(getAHREF()) on line \(lineNumber)<br><i>\(description)</i>"
        }
    }

    var measuredValue: String {
        return "\(count) times"
    }

    static func == (lhs: FileWarning, rhs: FileWarning) -> Bool {
        return lhs.line == rhs.line
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(line)
    }
}

extension PostBuildAnalzyer {
    func isFileWarning(line: String) -> Bool {
        return line.contains(FileWarning.lookFor)
    }
}
