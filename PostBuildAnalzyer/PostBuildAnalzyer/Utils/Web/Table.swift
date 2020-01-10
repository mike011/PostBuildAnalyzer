//
//  Table.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

struct TableHeader {
    let title: String
    let alignment: Alignment?
}

class Table: Element {
    private var headers: [TableHeader]
    private var rows = [[String]]()

    init(headers: [TableHeader]) {
        self.headers = headers
    }

    func addRow(columns: [String]) {
        rows.append(columns)
    }

    func toHTML() -> [String] {
        var result = [String]()
        guard !rows.isEmpty else {
            return result
        }
        result.append("<table>")
        result.append("<tr>")
        for header in headers {
            result.append("<th>\(header.title)</th>")
        }
        result.append("</tr>")
        for row in rows {
            result.append("<tr>")
            for x in 0 ..< row.count {
                let column = row[x]
                var align = ""
                if let alignment = headers[x].alignment {
                    align = " align=\"\(alignment)\"".lowercased()
                }
                result.append("<td\(align)>\(column)</td>")
            }
            result.append("</tr>")
        }
        result.append("</table>")
        return result
    }

    func toMarkdown() -> [String] {
        var result = [String]()
        guard !rows.isEmpty else {
            return result
        }

        var headerRow = "|"
        var alignmentRow = "|"
        for header in headers {
            headerRow += "\(header.title)|"

            if let alignment = header.alignment {
                switch alignment {
                case .Left:
                    alignmentRow += ":---"
                case .Right:
                    alignmentRow += "---:"
                case .Center:
                    alignmentRow += ":---:"
                }
            } else {
                alignmentRow += "---"
            }
            alignmentRow += "|"
        }
        result.append(headerRow)
        result.append(alignmentRow)

        for row in rows {
            var rowString = "|"
            for column in row {
                rowString += column + "|"
            }
            result.append(rowString)
        }
        return result
    }
}
