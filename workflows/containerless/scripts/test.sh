#!/bin/bash
set -e

# load dependencies
source ./workflows/containerless/scripts/env-setup.sh

cd ./submodules/pEVSL/TESTS/Lap/

mpirun \
    -np 1 ./LapPLanN.ex \
    -n 400 ./LapPLanN.ex \
    -nx 20 -ny 20 -nz 20 -nslices 5 -a 0.6 -b 1.2
