# FROM python:3.11

# RUN pip install --no-cache-dir jupyterlab requests pandas ollama 

FROM python:3.11

# directorio de trabajo
WORKDIR /workspace

# code-server (VSC)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# librerías de Python
RUN pip install --no-cache-dir jupyterlab requests pandas ollama

# extensiones VSC
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension ms-toolsai.jupyter

# puertos necesarios
# VSC
EXPOSE 8080
# jupyter
EXPOSE 8888 
# ollama
EXPOSE 11434

# inicio
CMD ["sh", "-c", "code-server --bind-addr 0.0.0.0:8080 --auth none /workspace & jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=''"]
