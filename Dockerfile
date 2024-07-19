FROM python:3.11

# workspace
WORKDIR /workspace

# code-server (VSC)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Python's requeriments
RUN pip install --no-cache-dir pandas ollama

# VSC's extensions
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension ms-toolsai.jupyter

# ports
# VSC
EXPOSE 8080
# ollama
EXPOSE 11434

# start

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh
ENTRYPOINT ["/startup.sh"]