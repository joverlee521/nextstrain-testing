
rule a:
    input: "shared/reference.fasta"
    output: touch("nextclade/results/all.txt")
