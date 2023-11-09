#!/usr/bin/env bash

./bin/local-script | tee "${snakemake_output[0]}"
