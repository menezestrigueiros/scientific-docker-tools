#!/bin/bash
set -e

# Only enable X11 if NOT in Codespaces
if [ -z "$CODESPACES" ]; then
    echo "[INFO] Allowing Docker containers to use X11 display..."
    xhost +local:docker > /dev/null
else
    echo "[INFO] Running inside GitHub Codespaces, skipping X11 setup."    
fi

echo "[INFO] Starting scientific tools container..."
# one of Docker Compose’s superpowers: If the image is not present locally, it pulls it from Docker Hub (or any registry you configured)
# Then it starts the container(s) defined in docker-compose.yml.
docker compose up -d

HOST_PORT=$(docker compose port scientific-tools 8888 | cut -d: -f2)

echo "[INFO] Waiting for Jupyter to be ready..."
until TOKEN=$(docker compose exec -T scientific-tools jupyter server list 2>/dev/null | grep -oP 'token=\K[0-9a-f]+'); do
    sleep 1
done
echo "[INFO] Token found!"
echo "[INFO] JupyterLab is ready!"
echo "[INFO] Open this URL to select the kernel:"
echo "       http://127.0.0.1:${HOST_PORT}/lab?token=${TOKEN}"


# (Optionally) Show JupyterLab logs
#echo "[INFO] Logs will show JupyterLab token (press Ctrl+C to stop logs):"
#docker compose logs -f scientific-tools