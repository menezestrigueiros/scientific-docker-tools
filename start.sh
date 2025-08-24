#!/bin/bash
set -e

# Only enable X11 if NOT in Codespaces
if [ -z "$CODESPACES" ]; then
    echo "[INFO] Allowing Docker containers to use X11 display..."
    xhost +local:docker > /dev/null
else
    echo "[INFO] Running inside GitHub Codespaces, skipping X11 setup."
    export JUPYTER_PORT=0
fi

echo "[INFO] Starting scientific tools container..."
# one of Docker Compose’s superpowers: If the image is not present locally, it pulls it from Docker Hub (or any registry you configured)
# Then it starts the container(s) defined in docker-compose.yml.
docker compose up -d

# Here, you copy your token and paste it in the browser or vscode.
echo "[INFO] Logs will show JupyterLab token (press Ctrl+C to stop logs):"
docker compose logs -f scientific-tools