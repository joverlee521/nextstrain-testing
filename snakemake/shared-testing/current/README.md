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

However, the `include` directive _must_ be relative the Snakefile it's defined in.
This results in a slight mismatch in filepaths.
