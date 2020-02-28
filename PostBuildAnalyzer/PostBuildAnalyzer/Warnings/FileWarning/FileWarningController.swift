//
//  FileWarning.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class FileWarningController: WarningController {
    init(repoURL: String, branch: String, line: String) {
        let model = FileWarningModel(repoURL: repoURL, branch: branch, line: line)
        let view = FileWarningView()
        super.init(model: model, view: view)
    }
}

extension PostBuildAnalyzer {
    static func isFileWarning(line: String) -> Bool {
        return line.contains(FileWarningModel.lookFor)
            && !line.contains(SlowExpressionController.slowCompileFile)
    }
}
