#!/bin/bash

# Run code for create ollama model
# Flag file path

FLAG_FILE="/workspace/.model_initialized"

if [ ! -f "$FLAG_FILE" ]; then
    
    ollama pull llama3.1:70b
    sleep 10
    ollama create analyze_llama3-1_70b -f /workspace/modelfile_llama3-1_70b

    touch "$FLAG_FILE"
fi

# Start code-server
code-server --bind-addr 0.0.0.0:8080 --auth none /workspace &

# Start Jupyter Lab
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root &

# Wait for all background processes to finish
wait