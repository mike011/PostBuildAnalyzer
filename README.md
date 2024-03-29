# PostBuildAnalyzer
After an iOS build has completed parse the log file and provide any other helpful logging information.

# How to Use
Call the PostBuildAnalyzer executable pointing to two json files. The first file represents the base branch that you want to compare against. Most of the time this file will be pointing to the `main` branch of your repo. The second file contains all the relevant information to the branch you are on. Both files contain the same amount of information. Here is what the layout looks like for the base branch 
<code>
{
    "repoURL": "https://github.com/mike011/PostBuildAnalyzer",
    "branch": "master",
    "outputFolder": "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/", #Optional
    "logFileName": "Example-Example (Before).log", #Optional
    "baseURLPath": "https://mike011.github.io/PostBuildAnalyzer/before/", #Optional
    "lintFileName": "lint.html", #Optional
    "buildTimeThresholdInMS": 10 #Optional
}
</code>

# Live Example
https://mike011.github.io/PostBuildAnalyzer/example.html

# Example

<h3>New Warnings</h3>
 
|  |Description|Amount|
|:---:|---|:---:|
|⚠️|<a href="https://github.com/mike011/PostBuildAnalyzer/blob/master/example/After/Example/Warnings.swift#L14">Warnings.swift</a> on line 14<br><i>'flatMap' is deprecated: Please use compactMap(_:) for the case where closure returns an optional value</i>|1 times|
|⚠️|<a href="https://github.com/mike011/PostBuildAnalyzer/blob/master/example/After/Example/Warnings.swift#L14">Warnings.swift</a> on line 14<br><i>initialization of immutable value 'index' was never used; consider replacing with assignment to '_' or removing it</i>|1 times|
|🚨|directory not found for option '-LNOT_A_REAL_LIB_PATH'|1 times|

<h3>Fixed Warning</h3>
 
|  |Description|Amount|
|:---:|---|:---:|
|⚠️|<a href="https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/SlowFiles.swift#L36">SlowFiles.swift</a> on line 36<br><i>expression took 2010ms to type-check (limit: 100ms)</i>|1 times|
|⚠️|<a href="https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/Warnings.swift#L14">Warnings.swift</a> on line 14<br><i>'index(of:)' is deprecated: renamed to 'firstIndex(of:)'</i>|1 times|
|⚠️|<a href="https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/Warnings.swift#L14">Warnings.swift</a> on line 14<br><i>value 'index' was defined but never used; consider replacing with boolean test</i>|1 times|
|⚠️|<a href="https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/Warnings.swift#L21">Warnings.swift</a> on line 21<br><i>'index(of:)' is deprecated: renamed to 'firstIndex(of:)'</i>|1 times|
|⚠️|<a href="https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/Warnings.swift#L21">Warnings.swift</a> on line 21<br><i>value 'index' was defined but never used; consider replacing with boolean test</i>|1 times|
|🚨|directory not found for option '-FNOT_A_REAL_PATH'|1 times|
|🧽|<a href="https://github.com/mike011/PostBuildAnalyzer/blob/master/Example/SlowFiles.swift#L32">SlowFiles.swift</a> on line 32<br><i>Collection literals should not have trailing commas.</i>|1 times|
|🧽|<a href="https://github.com/mike011/PostBuildAnalyzer/blob/master/Example/SlowFiles.swift#L37">SlowFiles.swift</a> on line 37<br><i>Files should have a single trailing newline.</i>|1 times|
<h3>Total Warnings</h3>
 
|  |📉|Description|Before|After|
|:---:|---|---|:---:|:---:|
||⏱|Files with compilation time >= 10.0ms|<a href="https://mike011.github.io/PostBuildAnalyzer/after/before.html">1</a>|<a href="https://mike011.github.io/PostBuildAnalyzer/after/after.html">1</a>|
|👍|⚠️|Build Warnings|<a href="https://mike011.github.io/PostBuildAnalyzer/after/before.html">5</a>|<a href="https://mike011.github.io/PostBuildAnalyzer/after/after.html">2</a>|
||🚨|Linker Warnings|<a href="https://mike011.github.io/PostBuildAnalyzer/after/before.html">1</a>|<a href="https://mike011.github.io/PostBuildAnalyzer/after/after.html">1</a>|
|👍|🧽|Lint Warnings|<a href="https://mike011.github.io/PostBuildAnalyzer/after/before.html">2</a>|<a href="https://mike011.github.io/PostBuildAnalyzer/after/after.html">0</a>|
|👍||Total Warnings|9|4|
Program ended with exit code: 0
