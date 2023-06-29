import pathlib
from snakemake.shell import shell

bin = pathlib.Path(__file__).parent.resolve()

fetch_param = snakemake.params.get("fetch_param", "")
log = snakemake.log_fmt_shell(stdout=True, stderr=True)


shell(
    "{bin}/fetch {fetch_param} | tee {snakemake.output[0]} {log}"
)
