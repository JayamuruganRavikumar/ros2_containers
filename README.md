
# ROS2 Containers

A unified CLI tool for building and running ROS2 Docker containers with GPU support.

## Installation

```bash
./install.sh
```

Make sure `~/.local/bin` is in your PATH. Add this to your `~/.bashrc` if needed:
```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Usage

### Building Containers
```bash
ros2_containers build <distro> [device] [purpose]
```

Examples:
- `ros2_containers build humble nvidia` - Build ROS2 Humble with NVIDIA GPU support
- `ros2_containers build foxy jetson mediapipe` - Build Foxy with Jetson and MediaPipe support

### Running Containers
```bash
ros2_containers run <distro> [device] [purpose]
```

Examples:
- `ros2_containers run humble nvidia` - Run/attach to Humble NVIDIA container
- `ros2_containers run foxy jetson mediapipe` - Run Foxy Jetson MediaPipe container

### Listing Available Options
```bash
ros2_containers list                    # List all Dockerfiles
ros2_containers list humble             # List devices for humble
ros2_containers list humble nvidia      # List purposes for humble-nvidia
```

### Configuration
```bash
ros2_containers config                           # Show current config
ros2_containers config set storage_path <path>  # Set storage path template
```

Storage path supports variables: `{distro}`, `{device}`, `{purpose}`
- Example: `~/docker_storage/ros-{distro}-{device}`

## Available Dockerfiles

- **Base**: `Dockerfile.ros2` - Basic ROS2 installation
- **Device-specific**: `Dockerfile.ros2_<distro>.<device>` (nvidia, jetson)
- **Purpose-specific**: `Dockerfile.ros2_<distro>.<device>.<purpose>` (mediapipe, yolo, etc.)

## Features

- **GPU Support**: Automatic NVIDIA GPU passthrough for containers
- **GUI Support**: X11 forwarding for RViz, Gazebo, etc.
- **Persistent Storage**: Configurable workspace directories
- **Container Reuse**: Automatically attaches to running containers
- **Multi-stage Builds**: Optimized container sizes

## Configuration File

Located at `build/ros2_containers.conf`:
```bash
# Storage path template with variables
STORAGE_PATH=~/Documents/docker_storage/ros-{distro}

# Default values
DEFAULT_DEVICE=nvidia
DEFAULT_DISTRO=humble
WORKSPACE_SUBDIR=ros2_ws/src
```

