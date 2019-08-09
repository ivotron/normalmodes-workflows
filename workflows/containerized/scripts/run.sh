#!/usr/bin/env bash
set -e
#SBATCH -J s1p1test
#SBATCH -o s1p1test_%j.txt
#SBATCH -e errs1p1test_%j.err
#SBATCH -p skx-dev
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=48
##SBATCH -c 4
#SBATCH --export=ALL
#SBATCH --time=2:00:00
#SBATCH -A TG-EAR170019


if [ -z "$MPI_NUM_PROCESSES" ]; then
  echo "No MPI_NUM_ROCESSES variable defined"
  exit 1
fi
if [ -z "$INPUT_DIR" ]; then
  echo "No INPUT_DIR variable defined"
  exit 1
fi

NMBIN="$GITHUB_WORKSPACE/submodules/NormalModes/bin/plmvcg_popper.out"
cd "$GITHUB_WORKSPACE/$INPUT_DIR"

mpirun \
  --allow-run-as-root \
  -np "$MPI_NUM_PROCESSES" \
  --mca btl_base_warn_component_unused 0 \
  "$NMBIN" > $GITHUB_WORKSPACE/workflows/containerized/normalmodes.log
