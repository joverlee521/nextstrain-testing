rule b_1:
    input: "results/b_2.txt"
    output: touch("results/b.txt")

rule b_2:
    input: "results/a.txt"
    output: touch("results/b_2.txt")
