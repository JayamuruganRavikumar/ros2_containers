#!/bin/zsh

distro_name=$1
nvidia=$2
DOCKER_BUILDKIT=1


if [ "$nvidia" -eq 1 ]
then
	echo "Building ros$distro_name using Dockerfile.ros2_$distro_name.nvidia"
	echo "Creating a directory for ros files"
	mkdir -p ~/Documents/docker_storage/ros-$distro_name-nvidia/ros2_ws/src/
else
	echo "Building ros$distro_name using Dockerfile.ros2_$distro_name"
	echo "Creating a directory for ros files"
	mkdir -p ~/Documents/docker_storage/ros-$distro_name/ros2_ws/src/
fi

# add source to image .bashrc
echo "source /opt/ros/$distro_name/setup.bash" >> bash_lines.txt

if [ "$nvidia" -eq 1 ]
then
	sudo docker build -t ros:$distro_name-nvidia -f Dockerfile.ros2_$distro_name.nvidia .
else
	sudo docker build -t ros:$distro_name -f Dockerfile.ros2_$distro_name .
fi

head -n -1 bash_lines.txt > temp.txt ; mv temp.txt bash_lines.txt
