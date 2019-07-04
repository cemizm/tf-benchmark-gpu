#!/bin/bash
exec 2> /dev/null

python tf_cnn_benchmarks.py "$@"
