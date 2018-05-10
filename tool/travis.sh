#!/usr/bin/env bash

set -e

# Check arguments.
TASK=$1
COMPILER=$2

if [ -z "$TASK" ]; then
  echo -e '\033[31mTASK argument must be set!\033[0m'
  echo -e '\033[31mExample: tool/travis.sh test:unit\033[0m'
  exit 1
fi

if [ -z "COMPILER" ]; then
  echo -e '\033[COMPILER argument must be set!\033[0m'
  echo -e '\033[31mExample: tool/travis.sh test:unit dartdevc\033[0m'
  exit 1
fi

case ${COMPILER} in
  dartdevc)
    ;;
  dart2js)
    ;;
  *)
    echo -e "\033[31mNot expecting COMPILER '${COMPILER}'. Error!\033[0m"
    exit 1
    ;;
esac

# Run the correct task type.
case $TASK in
  test:unit)
    echo -e "033[1mTASK: Testing [test]\033[22m"

    echo -e "pub build test --mode=debug --web-compiler=${COMPILER}"
    # Precompile tests to avoid timeouts/hung builds.
    pub build test --mode=debug --web-compiler=${COMPILER}
    # The --precompile option requires that it be given a merged output dir with
    # both compiled JS files and the source .dart files.
    # NOTE: Once we're on Dart 2 for good, we can switch to build_runner which
    # does all of this for us.
    # TODO: Switch to using build_runner for this
    cp -r test/ build/test/
    cp .packages build/
    sed 's/over_react:lib/over_react:..\/lib/' build/.packages > build/.packages.tmp && mv build/.packages.tmp build/.packages

    echo -e "pub run test --precompiled=build/ -P ${COMPILER} -P travis"
    pub run test --precompiled=build/ -P ${COMPILER} -P unit -P travis

    ;;

  test:integration)
    echo -e '\033[1mTASK: Testing [test]\033[22m'

    echo -e "pub build test --mode=debug --web-compiler=${COMPILER}"
    # Precompile tests to avoid timeouts/hung builds.
    pub build test --mode=debug --web-compiler=${COMPILER}
    # The --precompile option requires that it be given a merged output dir with
    # both compiled JS files and the source .dart files.
    # NOTE: Once we're on Dart 2 for good, we can switch to build_runner which
    # does all of this for us.
    # TODO: Switch to using build_runner for this
    cp -R test/** build/test/
    cp .packages build/
    sed 's/over_react:lib/over_react:..\/lib/' build/.packages > build/.packages.tmp && mv build/.packages.tmp build/.packages

    echo -e "pub run test --precompiled=build/ -P ${COMPILER} -P integration -P travis"
    pub run test --precompiled=build/ -P ${COMPILER} -P integration -P travis

    ;;

  *)
    echo -e "\033[31mNot expecting TASK '${TASK}'. Error!\033[0m"
    exit 1
    ;;
esac
