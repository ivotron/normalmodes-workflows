workflow "containers" {
  resolves = "run"
}

action "build" {
  uses = "./workflows/containerized/actions/normalmodes"
  runs = "./workflows/containerized/scripts/build.sh"
  env = {
    PEVSL_MAKEFILE_IN = "./workflows/containerized/makeconf/pEVSL_openblas.in"
    NORMALMODES_MAKEFILE_IN = "./workflows/containerized/makeconf/NormalModes_openblas.in"
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
}