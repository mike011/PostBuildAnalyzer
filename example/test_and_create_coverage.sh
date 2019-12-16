cd ./Before/Example
bundle exec fastlane test
cd ../../

cd ./After/Example
bundle exec fastlane test
cd ../../

./create_compare.sh
