workflow "containers" {
  resolves = "run"
}

action "build" {
  uses = "sh"
  runs = "workflows/containerless/scripts/build.sh"
  env = {
    PEVSL_MAKEFILE_IN = "workflows/containerless/makeconf/pEVSL_openblas.in"
    NORMALMODES_MAKEFILE_IN = "workflows/containerless/makeconf/NormalModes_openblas.in"
    NUM_BUILD_JOBS = "4"
  }
}

action "test" {
  needs = "build"
  uses = "sh"
  runs = "workflows/containerless/scripts/test.sh"
}

action "run" {
  needs = "test"
  uses = "sh"
  runs = "./workflows/containerless/scripts/run.sh"
  env = {
    MPI_NUM_PROCESSES = "1"
  }
}
