BEFORE='./Before/Example/fastlane/test_output/Example (Before).test_result/2_Test/action.xccovreport'
xcrun xccov view  --json "$BEFORE" --json > './Before/Example/fastlane/test_output/coverage.json'

AFTER='./After/Example/fastlane/test_output/Example (After).test_result/2_Test/action.xccovreport'
xcrun xccov view  --json "$AFTER" --json > './After/Example/fastlane/test_output/coverage.json'
