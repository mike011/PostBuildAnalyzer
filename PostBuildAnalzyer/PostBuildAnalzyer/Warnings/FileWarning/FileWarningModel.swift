//
//  FIleWarningModel.swift
//
//
//  Created by Michael Charland on 2019-12-25.
//

import Foundation

// This is the Model
class FileWarningModel: WarningModel, URLParser {
    var line: String

    static var lookFor = ": warning: "

    /// The url of repository
    /// eg: https://github.com/mike011/PostBuildAnalyzer
    let repoURL: String

    /// The branch the build is on.
    /// eg: master
    let branch: String

    /// The file in which the error occurred
    var file: String

    var url: URL?

    /// The line number on which the error occurred
    var lineNumber: Int

    var description: String

    /// The line in which the error occurred
    var details = [String]()

    /// How many times the error occurred
    var count = 1

    init(repoURL: String, branch: String, firstLine: String) {
        self.line = firstLine
        self.repoURL = repoURL
        self.branch = branch
        if let regex = try? NSRegularExpression(pattern: ":\\d+:\\d+" + Self.lookFor) {
            guard regex.matches(firstLine) else {
                self.file = ""
                self.lineNumber = -1
                // self.indent = -1
                self.description = firstLine
                return
            }
        }

        // craate Link
        var line = firstLine

        var end = line.firstIndex(of: ":")!
        self.file = String(line[..<end]).trimmingCharacters(in: .whitespacesAndNewlines)
        self.lineNumber = Self.getLineNumber(line: line) ?? 0
        self.url = Self.getURL(from: line, repoURL: repoURL, branch: branch)

        var start = line.index(end, offsetBy: 1)
        line = String(line[start...])
        end = line.firstIndex(of: ":")!
        self.lineNumber = Int(String(line[..<end]))!

        start = line.index(end, offsetBy: 1)
        line = String(line[start...])
        end = line.firstIndex(of: ":")!

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

    func getFilename() -> String {
        guard let url = url else {
            return ""
        }

        return url.lastPathComponent
    }
}
