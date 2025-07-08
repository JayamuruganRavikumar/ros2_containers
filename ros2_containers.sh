#!/bin/sh

while [[ $# -gt 0 ]]; do
	case $1 in
		--gpu|-g)
			device_type="$2"
			shift
			shift
			;;
		--distro|-d)
			distro_name="$2"
			shift
			shift
			;;
		--help)
			echo "Usage; [--help] [--gpu|-g <nvidia>] [--distro|-d] <distro>]"
			exit 0
			;;
		*)
			echo "Unknown argument: $1"
			exit 1
			;;
	esac
done

IFS=' ' read -r VARDPY VARPROTO VARHEX <<< $(xauth list)

if [ -z "$distro_name" ]; then
	echo "$(tput setaf 6)*************************************$(tput sgr0)"
	echo "$(tput setaf 3)-----Defaulting to humble distro-----$(tput sgr0)"
	echo "$(tput setaf 6)*************************************$(tput sgr0)"
	distro_name="humble"
else
	echo "$(tput setaf 6)*******************************************$(tput sgr0)"
	echo "$(tput setaf 3)-----Using ros:$distro_name-$device_type image-----$(tput sgr0)"
	echo "$(tput setaf 6)*******************************************$(tput sgr0)"
fi

if [ "$device_type" = "nvidia" ] || [ "$device_type" = "jetson" ]; then

	container_name="ros-$distro_name-$device_type"
else
	container_name="ros-$distro_name"
fi

echo "$(tput setaf 3)--Using $container_name as container name--$(tput sgr0)"
echo "$(tput setaf 6)*******************************************$(tput sgr0)"

if [ "$(sudo docker ps -a --quiet --filter status=running --filter name=$container_name)" ]; then
	echo "$(tput setaf 6)*************************************************$(tput sgr0)"
	echo "$(tput setaf 1)-----Found runnning $container_name container-----$(tput sgr0)"
	echo "$(tput setaf 6)*************************************$(tput sgr0)"
	echo "$(tput setaf 6)-----Attaching into existing $container_name-----$(tput sgr0)"
	echo "$(tput setaf 6)*************************************************$(tput sgr0)"
    sudo docker exec -i -t \
		$container_name \
		/bin/bash

    exit 0
fi

xhost +local:docker

start_docker(){

	local name=$1
	docker_args+=("-e NVIDIA_DRIVER_CAPABILITIES=all")
	docker_args+=("-e NVIDIA_VISIBLE_DEVICES=all")
	sudo docker run -it --rm \
				--gpus all \
				--net=host \
				--env="DISPLAY"\
				-e DISPLAY=$DISPLAY \
				"${docker_args[@]}" \
				-v ~/Documents/docker_storage/$container_name:/home/ \
				-v /tmp/.X11-unix:/tmp/.X11-unix \
				--device=/dev/dri:/dev/dri \
				--entrypoint='' \
				--name="$container_name" ros:"$name" \
				/bin/bash

}

#To do
#docker_args=()

if [ ! -z "$device_type" ];then
	start_docker "$distro_name-$device_type"
	
else
	start_docker "$distro_name"

fi
