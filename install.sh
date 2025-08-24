#!/bin/bash

# Simple installation script for ros2_containers

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create user bin directory
mkdir -p ~/.local/bin

# Symlink the main script
ln -sf "$SCRIPT_DIR/ros2_containers" ~/.local/bin/ros2_containers

echo "Installed ros2_containers to ~/.local/bin/"
echo "Make sure ~/.local/bin is in your PATH"
