//
//  Row.swift
//  CodeCoverageFramework
//
//  Created by Michael Charland on 2019-11-12.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation

struct Row {
    var change: String {
        var change = ""

        guard var beforeCoverage = beforeCoverage else {
            if var afterCoverage = afterCoverage {
                afterCoverage = afterCoverage.roundIt().truncate()
                return getCoverage(amount: afterCoverage)
            }
            return ""
        }
        beforeCoverage = beforeCoverage.roundIt().truncate()

        guard var afterCoverage = afterCoverage else {
            return ""
        }
        afterCoverage = afterCoverage.roundIt().truncate()

        if afterCoverage == 1 {
            return "💯"
        } else if afterCoverage == 0 {
            return "🚫"
        } else if beforeCoverage > afterCoverage {
            change = "👎"
        } else if afterCoverage > beforeCoverage {
            change = "👍"
        }
        return change
    }

    private func getCoverage(amount: Double) -> String {
        if amount == 1 {
            return "💯"
        } else if amount == 0 {
            return "🚫"
        }
        return "👍"
    }

    let sourceFile: String
    let beforeCoverage: Double?
    let afterCoverage: Double?
    var test: Bool {
        return sourceFile.contains("Test")
    }

    func toString(parentURL: String, end: String) -> String {
        let name = getLink(parentURL: parentURL, withEnd: end)
        return "|\(change)|\(name)|\(getPercentage(beforeCoverage))|\(getPercentage(afterCoverage))|"
    }

    private func getPercentage(_ value: Double?) -> String {
        guard let value = value else {
            return "-"
        }
        return String(format: "%.0f", value * 100) + "%"
    }

    private func getLink(parentURL: String, withEnd end: String) -> String {
        let name = getName()
        let url = "\(parentURL)\(name)\(end)"
        return "<a href=\(url)>\(name)</a>"
    }

    func getName() -> String {
        var name = sourceFile
        if let period = sourceFile.firstIndex(of: ".") {
            name = sourceFile.substring(to: period)
        }
        return name
    }
}

extension Row: Hashable {
    static func == (lhs: Row, rhs: Row) -> Bool {
        return lhs.sourceFile == rhs.sourceFile
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(sourceFile)
    }
}

private extension Double {
    func truncate() -> Double {
        return Double(floor(pow(10.0, Double(2)) * self) / pow(10.0, Double(2)))
    }

    func roundIt() -> Double {
        return Darwin.round(100 * self) / 100
    }
}
