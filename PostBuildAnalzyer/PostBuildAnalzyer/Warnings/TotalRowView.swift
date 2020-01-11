//
//  TotalRowView.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol TotalRowView {
    var symbol: String { get }
    var description: String { get }
    var before: [WarningController] { get set }
    var after: [WarningController] { get set }
}

class TotalTableRowModel: TableRowModel {
    var columns: [String]
    init(columns: [String]) {
        self.columns = columns
    }
}

extension TotalRowView {
    var change: String {
        var change = ""
        if before.count > after.count {
            change = "👍"
        } else if before.count < after.count {
            change = "👎"
        }
        return change
    }

    func row(baseURL: URL?) -> TableRowModel {
        let beforeCount = getAHREF(baseURL: baseURL, page: "before", title: before.count)
        let afterCount = getAHREF(baseURL: baseURL, page: "after", title: after.count)
        let columns = [change, symbol, description, beforeCount, afterCount]
        return TotalTableRowModel(columns: columns)
    }

    private func getAHREF(baseURL: URL?, page: String, title: Int) -> String {
        guard let baseURL = baseURL else {
            return String(title)
        }

        var url = baseURL.absoluteString
        if url.last != "/" {
            url += "/"
        }
        let urlString = "\(url)\(page).html"
        return HTML.getAHREF(url: URL(string: urlString)!, title: String(title))
    }

    var hasResults: Bool {
        return before.count > 0 || after.count > 0
    }
}
