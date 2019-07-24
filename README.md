# Normal Modes Workflows

This repository contains a list of [Github Action workflows][gha]
showcasing how to compute Normal Modes of Planetary Models using [pEVSL (parallel EigenValue Slicing Library)][pevsl].

This repository contains workflows in the `workflows/` folder
that showcase how to compute Normal Mode for a constant perfectly
spherically symmetric pure solid ball:
  1. [`containerized`](./workflows/containerized)
  2. [`containerless`](./workflows/containerless)

The first workflow run in a container runtime ([Docker][docker],
[Singularity][singularity], etc.), while another runs directly on
the host. These workflows can be executed with the [Popper CLI
tool][popper]. For example:

```bash
git clone --recursive https://github.com/ivortron/normalmodes-workflows

cd normalmodes-workflows/workflows/tpv33

popper run
```

For more information on each workflow, take a look at the `README`
file in each subfolder.

[pevsl]: https://github.com/js1019/pEVSL
[gha]: https://developer.github.com/actions/managing-workflows/workflow-configuration-options/#example-workflow
[popper]: https://github.com/systemslab/popper
[singularity]: https://github.com/sylabs/singularity
[docker]: https://get.docker.com