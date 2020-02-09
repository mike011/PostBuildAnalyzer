//
//  LintWarningController.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2020-02-05.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class LintWarningController: WarningController {
    init(repoURL: String, branch: String, line: String, file: String, location: String) {
        let model = LintWarningModel(repoURL: repoURL, branch: branch, line: line, file: file, location: location)
        let view = LintWarningView()
        super.init(model: model, view: view)
    }
}

extension PostBuildAnalyzer {
    func isLintWarning(line: String) -> Bool {
        return line.contains(LintWarningModel.lookFor)
    }
}
