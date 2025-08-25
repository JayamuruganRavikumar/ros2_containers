#!/bin/sh

# Simple installation script for ros2_containers

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create user bin directory
mkdir -p ~/.local/bin

# Symlink the main script
ln -sf "$SCRIPT_DIR/ros2-container" ~/.local/bin/ros2-container

echo "Installed ros2-container to ~/.local/bin/"
echo "Make sure ~/.local/bin is in your PATH"
