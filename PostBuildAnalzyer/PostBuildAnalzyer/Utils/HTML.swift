//
//  HTML.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class HTML {
    static func getAHREF(url: URL, title: String) -> String {
        return "<a href=\"\(url.absoluteString)\">\(title)</a>"
    }
}
