#!/bin/bash

# Run code for create ollama model

ollama pull tinyllama
sleep 10
ollama create analyze_tinyllama -f /workspace/modelfile_tinyllama

# Services start
code-server --bind-addr 0.0.0.0:8080 --auth none /workspace & 
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=''

wait
