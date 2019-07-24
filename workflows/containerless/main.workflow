workflow "containers" {
  resolves = "run"
}

action "build" {
  uses = "sh"
  args = "workflows/containerized/scripts/build.sh"
  env = {
    PEVSL_MAKEFILE_IN = "workflows/containerless/makeconf/pEVSL_openblas.in"
    NORMALMODES_MAKEFILE_IN = "workflows/containerless/makeconf/NormalModes_openblas.in"
  }
}

action "test" {
  needs = "build"
  uses = "sh"
  args = [
    "cd ./submodules/pEVSL/TESTS/Lap/ && mpirun --allow-run-as-root -np 1 ./LapPLanN.ex -n 400 ./LapPLanN.ex -nx 20 -ny 20 -nz 20 -nslices 5 -a 0.6 -b 1.2"
  ]
}

action "run" {
  needs = "test"
  uses = "sh"
  runs = "./workflows/containerized/scripts/run.sh"
}