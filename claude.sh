echo "Starting Claude with YOLO mode enabled..."
devcontainer exec --workspace-folder . claude --dangerously-skip-permissions $@
