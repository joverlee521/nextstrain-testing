## Trying Snakemake's piped outputs

Running workflow with the number of CPUs = number of connected piped outputs
```
nextstrain build --cpus 4 snakemake/piped-outputs/
```
This works as expected!


Running workflow with less CPUs results in error:
```
nextstrain build --cpus 1 snakemake/piped-outputs/
Building DAG of jobs...
Using shell: /bin/bash
Provided cores: 1 (use --cores to define parallelism)
Rules claiming more threads will be scaled down.
Job stats:
job      count
-----  -------
a            1
all          1
b            1
c            1
final        1
total        5

Select jobs to execute...
WorkflowError:
Error grouping resources in group 'ed992665-c9d6-4579-837d-1ddeb980f1ac': Not enough resources were provided. This error is typically caused by a Pipe group requiring too many resources. Note that resources are summed across every member of the pipe group, except for ['runtime'], which is calculated via max(). Excess Resources:
        _cores: 4/1
```
