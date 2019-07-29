# Normal Modes Workflows

This repository contains [Github Action workflows][gha] showcasing how 
to automate the computation of planetary-scale normal modes using the 
[NormalModes software package][nmgh]. Please refer to the NormalModes 
repository for detailed information on how this application works.

The workflows contained in the `workflows/` folder build the 
`NormalModes` application and its dependencies (they're part of this 
repository in the `submodules/` folder), and subsequently run a demo.

 1. [`containerized`](./workflows/containerized). This workflow runs 
    in a container runtime, specifically in [Docker][docker] or 
    [Singularity][singularity].

 2. [`containerless`](./workflows/containerless). This workflow runs 
    directly on the host machine and assumes that all dependencies 
    have been previously installed/loaded (`mpicc`, `make`, `mpi`, 
    etc.).

These workflows can be executed with the [Popper command line 
tool][popper]. For example:

```bash
git clone --recursive https://github.com/popperized/normalmodes-workflows

cd normalmodes-workflows/workflows/containerized

popper run
```

> **NOTE**: The `--recursive` flag is required in order to download > 
> the <https://github.com/js1019/pEVSL> and 
> <https://github.com/js1019/NormalModes> projects, > which are 
> submodules of this repository.

For more information on each workflow, take a look at the `README`
file in each corresponding subfolder.

[pevsl]: https://github.com/js1019/pEVSL
[gha]: https://developer.github.com/actions/managing-workflows/workflow-configuration-options/#example-workflow
[popper]: https://github.com/systemslab/popper
[singularity]: https://github.com/sylabs/singularity
[docker]: https://get.docker.com
[nm]: https://en.wikipedia.org/wiki/Normal_mode
[nmgh]: https://github.com/js1019/NormalModes
