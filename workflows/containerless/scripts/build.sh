#!/bin/bash
set -e

# load dependencies
source ./workflows/containerless/scripts/env-setup.sh

if [ ! -d "./submodules/pEVSL" ]; then
  echo "Expecting ./submodules/pEVSL/ folder"
  exit 1
fi
if [ ! -d "./submodules/NormalModes" ]; then
  echo "Expecting ./submodules/NormalModes/ folder"
  exit 1
fi

if [ -z "$PEVSL_MAKEFILE_IN" ]; then
  echo "Expecting PEVSL_MAKEFILE_IN variable"
  exit 1
fi
if [ -z "$NORMALMODES_MAKEFILE_IN" ]; then
  echo "Expecting NORMALMODES_MAKEFILE_IN variable"
  exit 1
fi
if [ -z "$NUM_BUILD_JOBS" ]; then
  echo "Expecting NUM_BUILD_JOBS variable"
  exit 1
fi

# copy configuration
cp $PEVSL_MAKEFILE_IN submodules/pEVSL/makefile.in

# build lib
pushd submodules/pEVSL
make -j"$NUM_BUILD_JOBS"

# build tests
pushd TESTS/Lap
make -j"$NUM_BUILD_JOBS"

popd
popd

# copy configuration
cp $NORMALMODES_MAKEFILE_IN submodules/NormalModes/makefile.in

# build lib
pushd submodules/NormalModes/src
make -j"$NUM_BUILD_JOBS"
