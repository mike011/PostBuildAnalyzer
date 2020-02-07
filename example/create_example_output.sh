# cleanup
rm -rf ../docs/example.html
rm -rf ../docs/before
rm -rf ../docs/after

mkdir ../docs/before
mkdir ../docs/after

cp -R ./After/fastlane/test_output/report.html ../docs/example.html
cp -R ./After/fastlane/test_output/*.html ../docs/after
