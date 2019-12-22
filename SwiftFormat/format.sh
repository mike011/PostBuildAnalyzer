
# The folder to format the swift code in.
FOLDER=$1

if [ -z ${$+x} ]; then
  $FOLDER=./../
fi

# Get the directory that this script file exists in.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/swiftformat --swiftversion 5.0 --config $DIR/.swiftformat $FOLDER

exit $?
