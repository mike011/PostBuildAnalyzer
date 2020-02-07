//
//  SlowExpressionModel.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpressionModel: WarningModel, URLParser {
    static var lookFor = "⏱"

    var line: String
    var description: String
    var count = 1.0

    /// The file in which the error occurred
    var file: String

    /// The URL of the error that occurred
    var url: URL

    /// The line number on which the error occurred
    var lineNumber: Int

    /// How long it took to compile
    var timeInMS: Double

    init(repoURL: String, branch: String, line: String) {
        let splits = Utils.getSplits(description: line)

        self.timeInMS = Self.parseTimeInMS(line: splits[0])
        self.file = splits[1]
        self.url = URL(fileURLWithPath: file)
        self.lineNumber = 0
        self.line = "\(file) \(lineNumber)"

        self.description = splits[2]

        // Does the file contains the line and index numbers?
        if let regex = try? NSRegularExpression(pattern: ":\\d+:\\d+"),
            regex.matches(file) {
            if let colonIndex = file.firstIndex(of: ":") {
                let parsedFileName = String(file[..<colonIndex])

                let startIndex = file.index(colonIndex, offsetBy: 1)
                let rest = String(file[startIndex...])
                if let colonIndex = rest.firstIndex(of: ":") {
                    self.lineNumber = Int(String(rest[..<colonIndex])) ?? 0
                }

                self.file = parsedFileName
            }
        }

        if let url = Self.getURL(file: file, lineNumber: lineNumber, repoURL: repoURL, branch: branch) {
            self.url = url
        }

        self.file = Self.getPath(file: file, repoName: Self.getRepoName(fromRepoURL: repoURL))
    }

    static func parseTimeInMS(line: String) -> Double {
        let start = line.firstIndex(of: "m")!
        let time = String(line[..<start])
        return Double(time) ?? 0.0
    }

    func getFilename() -> String {
        return url.lastPathComponent
    }
}
