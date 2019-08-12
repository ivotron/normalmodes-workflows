workflow "NormalModes scaling test" {
  resolves = "run"
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

action "install sweepj2" {
  needs = "test"
  uses = "jefftriplett/python-actions@master"
  args = "pip install sweepj2"
}

action "delete existing jobs" {
  needs = "install sweepj2"
  uses = "actions/bin/sh@master"
  args = ["rm -rf workflows/scaling-test/sweep/jobs"]
}

action "generate sweep" {
  needs = "delete existing jobs"
  uses = "jefftriplett/python-actions@master"
  args = [
    "sweepj2",
    "--template", "./workflows/scaling-test/sweep/script.j2",
    "--space", "./workflows/scaling-test/sweep/space.yml",
    "--output", "./workflows/scaling-test/sweep/jobs/",
    "--make-executable"
  ]
}

action "run" {
  needs = "generate sweep"
  uses = "./workflows/containerized/actions/normalmodes"
  args = "run-parts workflows/scaling-test/sweep/jobs"
  env = {
    # input parameters defined in global_conf file of this directory
    INPUT_DIR = "submodules/NormalModes/demos/"
  }
}