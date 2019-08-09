workflow "containers" {
  resolves = "generate vtk"
}

action "build" {
  uses = "./workflows/containerized/actions/normalmodes"
  runs = "./workflows/containerized/scripts/build.sh"
  env = {
    # Makefiles using MKL
    PEVSL_MAKEFILE_IN = "./workflows/containerized/makeconf/pEVSL_mkl.in"
    NORMALMODES_MAKEFILE_IN = "./workflows/containerized/makeconf/NormalModes_mkl.in"

    # Makefiles using OpenBLAS
    # PEVSL_MAKEFILE_IN = "./workflows/containerized/makeconf/pEVSL_openblas.in"
    # NORMALMODES_MAKEFILE_IN = "./workflows/containerized/makeconf/NormalModes_openblas.in"

    NUM_BUILD_JOBS = "1"
  }
}

action "test" {
  needs = "build"
  uses = "./workflows/containerized/actions/normalmodes"
  runs = [
    "sh", "-c",
    "cd ./submodules/pEVSL/TESTS/Lap/ && mpirun --allow-run-as-root -np 1 ./LapPLanN.ex -n 400 ./LapPLanN.ex -nx 20 -ny 20 -nz 20 -nslices 5 -a 0.6 -b 1.2"
  ]
}

action "run" {
  needs = "test"
  uses = "./workflows/containerized/actions/normalmodes"
  runs = "./workflows/containerized/scripts/run.sh"
  env = {
    MPI_NUM_PROCESSES = "1"

    # input parameters defined in global_conf file of this directory
    INPUT_DIR = "submodules/NormalModes/demos/"
  }
}

action "validate" {
  needs = "run"
  uses = "actions/bin/sh@master"
  runs = "./workflows/containerized/scripts/validate.sh"
}

# input parameters defined in visualCmain.m file
action "generate vtk" {
  needs = "validate"
  uses = "docker://popperized/octave:4.4"
  args = "./workflows/containerized/scripts/visualCmain.m"
}
