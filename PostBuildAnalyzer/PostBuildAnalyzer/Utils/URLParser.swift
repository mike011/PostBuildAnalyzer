//
//  URLParser.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol URLParser {}

extension URLParser {
    static func getURL(file: String, lineNumber: Int?, repoURL: String, branch: String) -> URL? {
        let repoName = Self.getRepoName(fromRepoURL: repoURL)
        let path = Self.getPath(file: file, repoName: repoName)

        var urlString = "\(repoURL)/blob/\(branch)/\(path)"
        if let lineNumber = lineNumber {
            urlString += "#L\(lineNumber)"
        }

        return URL(string: escape(urlString))
    }

    static func escape(_ string: String) -> String {
        return string.replacingOccurrences(of: " ", with: "%20")
    }

    static func getRepoName(fromRepoURL repoURL: String) -> String {
        if let range = repoURL.range(of: "/", options: .backwards) {
            return String(repoURL[range.upperBound...])
        }
        return repoURL
    }

    static func getPath(file: String, repoName: String) -> String {
        let circleFolder = "/Users/distiller/project/"
        let bitriseFolder = "/Users/vagrant/git/"
        if file.contains(repoName),
            let range = file.range(of: repoName + "/") {
            return String(file[range.upperBound...])
        } else if let range = file.range(of: circleFolder) {
            return String(file[range.upperBound...])
        } else if let range = file.range(of: bitriseFolder) {
            return String(file[range.upperBound...])
        }
        return file
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
