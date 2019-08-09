# SCC19 Workflow

This workflow automates the computation of the normal mode at 
planetary scales using the [NormalModes software package][nmgh].

## Workflow

The [workflow](./main.workflow) consists of following actions:

  * **`build`**. Invokes the [`build.sh` script](./scripts/build.sh) 
    script, which builds both `pEVSL` and `NormalModes`. These can be 
    built against [Intel's MKL][mkl] or [OpenBlas][oblas] libraries by 
    choosing the corresponding Makefile available in the 
    [`makeconf/`](./makeconf) folder. The number of jobs used during 
    the build (passed to Make via the `-j` flag) is controlled by a 
    `NUM_BUILD_JOBS` environment variable.

  * **`test`**. Executes short-running tests for `pEVSL`.

  * **`run`**. Invokes the [`run.sh` script](./scripts/run.sh), which 
    obtains the normal mode for one of the input models available in 
    the [`NormalModes/demos/`][demos] folder. The `global_conf` file 
    in this directory can be modified to run other demos. The variable 
    `MPI_NUM_PROCESSES` is used to specify the number of MPI processes 
    to use for the job.

  * **`validate`**. Checks the relative error, if its small (of the order ~10^-10)
  the check passes, otherwise fails.

  * **`generate vtk`**. Creates the `.vtk` file, by running the [visualCmain.m](./scripts/visualCmain.m)
  and reading the parameters like `JOB`, `pOrder`, `nporc` etc from the file.

## Execution

This workflow runs in a container runtime ([Docker][docker] and 
[Singularity][singularity]) and can be executed with the [Popper CLI 
tool][popper]. For a version of this workflow in a non-containerized 
environment, see [here](../containerless). The following executes this 
workflow:

```bash
git clone --recursive https://github.com/ivotron/scc19-workflows
cd scc19-workflows/workflows/containerized

popper run
```

> **NOTE**: The `--recursive` flag is required in order to download 
> the <https://github.com/js1019/pEVSL> and 
> <https://github.com/js1019/NormalModes> projects, which are 
> submodules of this repository (in [`submodules/` 
> folder](../../submodules)).

To run in Singularity:

```bash
popper run --runtime singularity
```

Sample output
(trimmed to only show end of execution):

```
 Row    261   1.9575838917916459        510.83379067078789
 Row    262   1.9654674111834070        508.78482864180404
 Row    263   1.9685489784113608        507.98837670120372
 Row    264   1.9764339222924401        505.96176716098506
 Row    265   1.9781774331264217        505.51582646433508
 Row    266   1.9809330184699281        504.81262651293457
 Row    267   1.9843952373083178        503.93186861122706
 Row    268   1.9860365613548143        503.51540321988341
 Row    269   1.9944091633034535        501.40162730883316
 Row    270   1.9972354448512162        500.69209545522301
 Row    271   1.9998649254669882        500.03377091404815
 ================================================================
 save eigenvectors
 Time elapsed =    41.091000000014901      seconds.
 save the results
 Time elapsed =    41.091999999945983      seconds.
 Time elapsed =    41.091999999945983      seconds.
```

## Visualization

To visualize the `.vtk` file you can run [ParaView Web][paraview]
on your system by using the [Docker ParaView Web][pvw-docker].


[pevsl]: https://github.com/js1019/pEVSL
[planetary-model]: https://github.com/js1019/PlanetaryModels#planetary-model-builder
[mkl]: https://software.intel.com/en-us/mkl
[oblas]: https://github.com/xianyi/OpenBLAS/wiki
[make]: https://www.gnu.org/software/make/manual/make.html
[docker]: https://get.docker.com
[popper]: https://github.com/systemslab/popper
[singularity]: https://github.com/sylabs/singularity
[demos]: https://github.com/js1019/NormalModes/tree/master/demos
[nmgh]: https://github.com/js1019/NormalModes
[pvw-docker]: https://github.com/ivotron/docker-paraviewweb
[paraview]: http://kitware.github.io/paraviewweb/
