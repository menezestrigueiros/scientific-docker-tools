#!/bin/bash
set -e

echo "[INFO] Allowing Docker containers to use X11 display..."
xhost +local:docker > /dev/null

echo "[INFO] Starting scientific tools container..."
docker compose up -d

# Here, you copy your token and paste it in the browser or vscode.
echo "[INFO] Logs will show JupyterLab token (press Ctrl+C to stop logs):"
docker compose logs -f scientific-tools
