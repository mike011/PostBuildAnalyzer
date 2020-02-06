//
//  LintWarningModel.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2020-02-05.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class LintWarningModel: WarningModel, URLParser {
    var line: String

    var count = 1.0

    static let lookFor = "<td class=\"warning\">Warning</td>"
    var description: String
    var file: String
    var lineNumber: Int?
    var url: URL?

    init(repoURL: String, branch: String, line: String, file: String, location: String) {
        self.line = line
        self.file = file.stripTDs()
        self.lineNumber = Int(file.stripCenterTDs())
        self.description = line.stripTDs()
        self.url = Self.getURL(file: file, lineNumber: lineNumber, repoURL: repoURL, branch: branch)
    }

    func getFilename() -> String {
        guard let url = url else {
            return ""
        }

        return url.lastPathComponent
    }
}

private extension String {
    func stripTDs() -> String {
        if let start = range(of: "<td>")?.upperBound,
            let end = range(of: "</td>")?.lowerBound {
            return substring(to: end).substring(from: start)
        }
        return ""
    }

    func stripCenterTDs() -> String {
        if let start = range(of: "<td style=\"text-align: center;\">")?.upperBound,
            let end = range(of: "</td>")?.lowerBound {
            return substring(to: end).substring(from: start)
        }
        return ""
    }
}
