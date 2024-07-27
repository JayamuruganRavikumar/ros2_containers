#!/bin/sh

distro_name=$1
device_type=$2
DOCKER_BUILDKIT=1


if [ "$device_type" = "nvidia" ] || [ "$device_type" = "jetson"]; then
	echo "$(tput setaf 6)-------------------------------------$(tput sgr0)"
	echo "$(tput setaf 3)Building ros$distro_name using Dockerfile.ros2_$distro_name.$device_type$(tput sgr0)"
	echo "$(tput setaf 6)-------------------------------------$(tput sgr0)"
	echo "$(tput setaf 3)Creating a directory for ros files$(tput sgr0)"
	echo "$(tput setaf 6)-------------------------------------$(tput sgr0)"

	mkdir -p ~/Documents/docker_storage/ros-$distro_name-nvidia/ros2_ws/src/
	echo "source /opt/ros/$distro_name/setup.bash" >> bash_lines.txt

	sudo docker build -t ros:$distro_name-$device_type -f Dockerfile.ros2_$distro_name.$device_type .

else
	echo "$(tput setaf 6)-------------------------------------$(tput sgr0)"
	echo "$(tput setaf 3)Building ros$distro_name using Dockerfile.ros2_$distro_name$(tput sgr0)"
	echo "$(tput setaf 6)-------------------------------------$(tput sgr0)"
	echo "$(tput setaf 3)Creating a directory for ros files$(tput sgr0)"
	echo "$(tput setaf 6)-------------------------------------$(tput sgr0)"

	mkdir -p ~/Documents/docker_storage/ros-$distro_name/ros2_ws/src/
	echo "source /opt/ros/$distro_name/setup.bash" >> bash_lines.txt

	sudo docker build --build-arg BASE_IMAGE=$distro_name --build-arg DISTRO=$distro_name -t ros:$distro_name -f Dockerfile.ros2 .

fi

head -n -1 bash_lines.txt > temp.txt ; mv temp.txt bash_lines.txt
