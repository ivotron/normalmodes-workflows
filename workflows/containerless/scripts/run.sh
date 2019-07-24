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

export OMP_NUM_THREADS=2
#export MV2_ENABLE_AFFINITY=0

pushd ./submodules/NormalModes/demos
mpirun --allow-run-as-root -np 1 --mca btl_base_warn_component_unused 0 ./../bin/plmvcg_popper.out
popd