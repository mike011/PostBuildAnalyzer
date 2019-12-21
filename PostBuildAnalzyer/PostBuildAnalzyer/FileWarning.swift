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

    var file = ""
    var lineNumber = 0
    var indent = 0
    var description: String
    var details = [String]()
    var count: Int = 1

    init(firstLine: String) {

        if let regex = try? NSRegularExpression(pattern: ":\\d+:\\d+" + FileWarning.lookFor) {
            guard regex.matches(firstLine) else {
                description = firstLine
                return
            }
        }

        var line = firstLine
        var end = line.firstIndex(of: ":")!
        file = String(line[..<end]).trimmingCharacters(in: .whitespacesAndNewlines)

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
        if trimmed.contains("^") {
            details.append(String(repeating: " ", count: indent) + "^")
        } else {
            details.append(trimmed)
        }
    }
}
