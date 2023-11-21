
rule a:
    input: "shared/reference.fasta"
    output: touch("ingest/results/all.txt")
    params:
        script = "ingest/bin/echo-pwd"
    shell:
        """
        {params.script}
        """
