BEFORE='./Before/Example/fastlane/test_output/Example (Before).test_result.xcresult'
xcrun xccov view --report "$BEFORE" --json > './Before/Example/fastlane/test_output/coverage.json'

AFTER='./After/Example/fastlane/test_output/Example (After).test_result.xcresult'
xcrun xccov view --report "$AFTER" --json > './After/Example/fastlane/test_output/coverage.json'

EQUIVALENCE=/Users/michael/Documents/git/CodeCoverageCompare/example/Before,/Users/michael/Documents/git/CodeCoverageCompare/example/After
xcrun xccov diff --path-equivalence $EQUIVALENCE --json "$BEFORE" "$AFTER" >> './After/Example/fastlane/test_output/compare.json'
