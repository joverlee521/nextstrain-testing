
rule a:
    input: "shared/reference.fasta"
    output: touch("phylogenetic/results/all.txt")
