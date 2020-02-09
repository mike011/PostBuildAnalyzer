//
//  FIleWarningModel.swift
//
//
//  Created by Michael Charland on 2019-12-25.
//

import Foundation

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

    /// The URL of the error that occurred
    var url: URL?

    /// The line number on which the error occurred
    var lineNumber: Int?

    var description: String

    /// How many times the error occurred
    var count = 1.0

    init(repoURL: String, branch: String, line: String) {
        self.line = line
        self.repoURL = repoURL
        self.branch = branch

        guard let lookForIndex = line.range(of: Self.lookFor) else {
            self.file = ""
            self.description = line
            return
        }

        self.file = String(line[..<lookForIndex.lowerBound])
        self.description = String(line[lookForIndex.upperBound...])

        // Does the file contains the line and line and index numbers?
        if let regex = try? NSRegularExpression(pattern: ":\\d+:\\d+"),
            regex.matches(file) {
            if let colonIndex = file.firstIndex(of: ":") {
                let parsedFileName = String(file[..<colonIndex])

                let startIndex = file.index(colonIndex, offsetBy: 1)
                let rest = String(file[startIndex...])
                if let colonIndex = rest.firstIndex(of: ":") {
                    self.lineNumber = Int(String(rest[..<colonIndex]))
                }

                self.file = parsedFileName
            }
        }

        self.url = Self.getURL(file: file, lineNumber: lineNumber, repoURL: repoURL, branch: branch)
        self.file = Self.getPath(file: file, repoName: Self.getRepoName(fromRepoURL: repoURL))
    }

    func getFilename() -> String {
        guard let url = url else {
            return ""
        }

        return url.lastPathComponent
    }
}
