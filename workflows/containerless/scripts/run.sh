#!/usr/bin/env bash
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
set -e

# load dependencies
source ./workflows/containerless/scripts/env-setup.sh

if [ -z "$MPI_NUM_PROCESSES" ]; then
  echo "No MPI_NUM_ROCESSES variable defined"
  exit
fi

cd ./submodules/NormalModes/demos

mpirun -np "$MPI_NUM_PROCESSES" ../bin/plmvcg_popper.out
