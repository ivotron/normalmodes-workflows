#!/usr/bin/env bash
set -e

export GITHUB_WORKSPACE=$(pwd)

cat $GITHUB_WORKSPACE/workflows/containerized/normalmodes.log | grep "relative err. " > temp.log

while read p; do
  if [[ ${p: -2} -lt 10 ]]; then
    echo $p
    echo "Relative error is high. Validation Failed."
    exit 1
  fi
done <temp.log
rm temp.log
echo "Validation Successful"
