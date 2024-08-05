#!/bin/bash

# Run code for create ollama model
# Flag file path

FLAG_FILE="/workspace/.model_initialized"

# Wait for the ollama container to be ready
until docker exec ollama /bin/bash -c "echo ready"; do
    echo "Waiting for ollama container..."
    sleep 5
done

# Pull and create the model if not already initialized
if [ ! -f "$FLAG_FILE" ]; then
    echo "Pulling and creating the model in ollama container..."
    docker exec ollama /bin/bash -c "
        ollama pull llama3.1 &&
        ollama create analyze_llama3-1 -f /workspace/modelfile_llama3-1
    "
    touch "$FLAG_FILE"
fi

# Start code-server
code-server --bind-addr 0.0.0.0:8080 --auth none /workspace &

# Start Jupyter Lab
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root &

# Wait for all background processes to finish
wait