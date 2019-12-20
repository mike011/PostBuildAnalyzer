//
//  SimpleWarning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol SimpleWarning {
    static var lookFor: String { get }
    var descripton: String { get }
}
