# Current

This is the current proposed structure of files where there is a top level
`shared` directory.

```
├── .github/
├── ingest/
├── nextclade/
├── phylogenetic/
├── shared/
├── CHANGELOG.md
└── README.md
```

Rules within the phylogenetic workflow would then need to reach out to the top level
`shared` directory for files

```python
inputs:
    reference="../shared/reference.fasta"
```

This runs in to issues with the containerized runtimes that need to mount the
build directory.

# Final Decision

After all the testing done below, I've decided to use the hardcoded `workdir` in
workflows so that users can call the workflow by point to the main Snakefile
```
nextstrain build . -s phylogenetic/Snakefile
```

This can then easily be moved to a Nextstrain CLI option in the near future
that can point to the correct Snakefile under the hood
```
nextstrain build --workflow phylogenetic .
```


## Different nextstrain build commands

Trying various different `nextstrain build` commands in the Docker runtime for this design.

1. Running with the phylogenetic directory does not work because it does not have access to the
top level `shared` directory in the container
```
nextstrain build phylogenetic
Building DAG of jobs...
MissingInputException in rule a in file /nextstrain/build/rules/a.smk, line 2:
Missing input files for rule a:
    output: results/all.txt
    affected files:
        ../shared/reference.fasta
```

2. Running our usual command at the top level directory no longer works because there is no top level Snakefile.

```
nextstrain build .
Error: no Snakefile found, tried Snakefile, snakefile, workflow/Snakefile, workflow/snakefile.
```

3. Running from the top level with --snakefile/-s Snakemake option does not work
```
nextstrain build . -s phylogenetic/Snakefile
Building DAG of jobs...
MissingInputException in rule a in file /nextstrain/build/phylogenetic/rules/a.smk, line 2:
Missing input files for rule a:
    output: results/all.txt
    affected files:
        ../shared/reference.fasta
```

4. Running from the top level with --directory/-d Snakemake option does not work
```
$ nextstrain build . -d phylogenetic/
Error: no Snakefile found, tried Snakefile, snakefile, workflow/Snakefile, workflow/snakefile.
```

5. Providing both the -s and -d options work!
```
nextstrain build . -s phylogenetic/Snakefile -d phylogenetic/ --forceall
Building DAG of jobs...
Using shell: /bin/bash
Provided cores: 8
Rules claiming more threads will be scaled down.
Job stats:
job      count
-----  -------
a            1
all          1
total        2

Select jobs to execute...

[Fri Nov 17 23:14:42 2023]
localrule a:
    input: ../shared/reference.fasta
    output: results/all.txt
    jobid: 1
    reason: Forced execution
    resources: tmpdir=/tmp

Touching output file results/all.txt.
[Fri Nov 17 23:14:42 2023]
Finished job 1.
1 of 2 steps (50%) done
Select jobs to execute...

[Fri Nov 17 23:14:42 2023]
localrule all:
    input: results/all.txt
    jobid: 0
    reason: Input files updated by another job: results/all.txt
    resources: tmpdir=/tmp

[Fri Nov 17 23:14:42 2023]
Finished job 0.
2 of 2 steps (100%) done
Complete log: .snakemake/log/2023-11-17T231442.159506.snakemake.log
```

## Use top-level filepaths within workflows

We no longer have to provide the -d option if we define all inputs/outputs as
top-level filepaths within the workflows

```
nextstrain build . -s phylogenetic/Snakefile --forceall
Building DAG of jobs...
...
2 of 2 steps (100%) done
Complete log: .snakemake/log/2023-11-17T235501.777334.snakemake.log
```

Another positive here is the path names in the Snakemake logs are the full paths
relative to the pathogen repo, so users can easily see which files are used/created
in the workflow!

However, the `include` directive _must_ be relative the Snakefile it's defined in.
This results in a slight mismatch in filepaths.

## Use `workdir` directive

We can also get around the -d option by defining the working directory with the
`workdir` directive at the top of the workflow's Snakefile

```
nextstrain build . -s phylogenetic/Snakefile --forceall
Building DAG of jobs...
...
2 of 2 steps (100%) done
Complete log: ../.snakemake/log/2023-11-17T235925.951892.snakemake.log
```

## Built-in Snakemake variables/methods

Some built-in Snakemake variables that I considered using in setting up
the subdirectories and orchestrating the overall workflow.

1. `workflow.basedir` = the directory of the "main" Snakefile in the workflow
    - default = the top level Snakefile where snakemake was invoked
    - can be changed with the `--snakefile/-s` CLI option

2. `workflow.current_basedir` = the base directory of the current Snakefile
    - always points to the Snakefile it is used in regardless of include/modules/etc.

3. `workflow.source_path()` = allows us to specify a path relative to the current Snakefile
    - currently unusable due to [issue with cache tmp file triggering param changes that cause reruns](https://github.com/snakemake/snakemake/issues/1805)


## Orchestrate all workflows from the top level using Snakemake

Instead of relying on the users to specify the Snakefile to use in the workflows,
maybe we can help orchestrate all of the workflows from the top level?

### Sub-workflows

Non-starter because it has been marked as deprecated and will soon be removed
in [Snakemake v8](https://github.com/snakemake/snakemake/issues/2409).

Some other issues identified when testing out sub-workflows:
- Cannot specify a subworkflow target from the snakemake command
- The --forceall flag does not propagate to the subworkflow, so the main workflow
could potentially use local stale ingest outputs


### Modules

Snakemake is favoring modules instead of sub-workflows. However, there are a couple
issues with using modules for our intended use.

1. The working directory is always set the top level Snakefile that imports the modules.
This results in errors when trying to run local scripts with relative paths within
the modules (e.g. `./bin/notify-on-error` in ingest).
We would have to prefix all of these local scripts with a variable/config value that
can point to the correct directory.

2. The `prefix` directive does not work for the top level "shared" directory
because [Snakemake purposely not use prefix if the filepath starts with ".."]
(https://github.com/snakemake/snakemake/issues/1647).

3. From [Snakemake docs](https://snakemake.readthedocs.io/en/stable/snakefiles/modularization.html#modules):
> any Python variables and functions available in the module-defining namespace
will not be visible from inside the module. However, it is possible to pass
information to the module using the config

> any configfile statements inside the module are ignored.

This just seems like more trouble than it's worth to use after testing it out for a while...

### Include

One possibility is to change all paths to be relative to the top level directory
and just `include` all of the workflows in a top level Snakefile.

Some issues with this approach:
- All rule names must be unique _between_ workflows
- All config names must be unique _between_ workflows
- All required configs for _all_ workflows must be provided even when only running
a single workflow
- Perhaps confusion with top level paths vs workflow level paths due to how [Snakemake
handles relative filepaths](https://snakemake.readthedocs.io/en/stable/project_info/faq.html#how-does-snakemake-interpret-relative-paths).

### Conditionally include

We could conditionally include worklows by config value, so that the
workflow is only included when the config is set to a specific value

```
nextstrain build . -C workflow=phylogenetic
```

This doesn't seem that better than just calling the individual Snakefiles
with
```
nextstrain build . -s phylogenetic/Snakefile
```

### Profiles

I briefly played with the idea of using Snakemake profiles to point to the correct
Snakefile and directory for workflows, e.g.
```
nextstrain build . -p profiles/phylogenetic
```
However, as of Snakemake v7.32.3 (the version currently used in nextstrain-base),
[the Snakefile is checked _before_ the profile](https://github.com/snakemake/snakemake/blob/b76cfff4fbec3e53cfd46c7f32c3a5c0e9d6dc8a/snakemake/__init__.py#L2739-L2755) so we cannot
define the Snakefile in the profile.
