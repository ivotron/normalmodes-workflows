workflow "NormalModes scaling test" {
  resolves = "generate sweep"
}

action "install sweepj2" {
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
