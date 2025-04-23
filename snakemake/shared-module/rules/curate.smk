rule curate:
    output: "results/curate.txt"
    params:
        test=shared_workflow.resolve_config_path("test.txt"),
    shell:
        """
        echo {params.test:q} | tee {output:q}
        """
