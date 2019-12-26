//
//  URLParser.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol URLParser {}

extension URLParser {
    static func getURL(from line: String, repoURL: String, branch: String) -> URL? {
        let repoName = Self.getRepoName(fromRepoURL: repoURL)

        guard line.contains(":"),
            let path = Self.getPath(line: line, repoName: repoName),
            let lineNumber = Self.getLineNumber(line: line) else {
            return nil
        }

        return URL(string: "\(repoURL)/blob/\(branch)/\(path)#L\(lineNumber)")
    }

    static func getRepoName(fromRepoURL repoURL: String) -> String {
        if let range = repoURL.range(of: "/", options: .backwards) {
            return String(repoURL[range.upperBound...])
        }
        return repoURL
    }

    static func getPath(line: String, repoName: String) -> String? {
        guard let end = line.firstIndex(of: ":") else {
            return nil
        }
        let file = String(line[..<end]).trimmingCharacters(in: .whitespacesAndNewlines)

        let circleFolder = "/Users/distiller/project/"
        if file.contains(repoName),
            let range = file.range(of: repoName + "/") {
            return String(file[range.upperBound...])
        } else if let range = file.range(of: circleFolder) {
            return String(file[range.upperBound...])
        }
        return nil
    }

    static func getLineNumber(line: String) -> Int? {
        guard let startIndex = line.firstIndex(of: ":") else {
            return nil
        }

        let shorterLine = line[startIndex...].dropFirst()

        guard let endIndex = shorterLine.firstIndex(of: ":") else {
            return nil
        }

        let lineNumber = String(shorterLine[..<endIndex])
        return Int(lineNumber)
    }
}
