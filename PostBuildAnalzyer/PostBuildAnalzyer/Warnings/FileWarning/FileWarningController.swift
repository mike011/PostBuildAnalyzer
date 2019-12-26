//
//  FileWarning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

// This is the View
class FileWarningController: WarningController {
    init(repoURL: String, branch: String, firstLine: String) {
        let model = FileWarningModel(repoURL: repoURL, branch: branch, line: firstLine)
        let view = FileWarningView()
        super.init(model: model, view: view)
    }
}

extension PostBuildAnalzyer {
    func isFileWarning(line: String) -> Bool {
        return line.contains(FileWarningModel.lookFor)
    }
}
