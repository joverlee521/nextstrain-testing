
rule a:
    input: "../shared/reference.fasta"
    output: touch("results/all.txt")
    shell:
        """
        bin/echo-pwd
        """
