#!/bin/sh
IFS=' ' read -r VARDPY VARPROTO VARHEX <<< $(xauth list)
distro_name="$1"
device_type="$2"

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

echo "$(tput setaf 6)*******************************************$(tput sgr0)"
echo "$(tput setaf 3)--Using $container_name as container name--$(tput sgr0)"
echo "$(tput setaf 6)*******************************************$(tput sgr0)"

if [ "$(sudo docker ps -a --quiet --filter status=running --filter name=$container_name)" ]; then
	echo "$(tput setaf 6)*************************************$(tput sgr0)"
	echo "$(tput setaf 1)-----Found runnning $container_name container-----$(tput sgr0)"
	echo "$(tput setaf 6)*************************************$(tput sgr0)"
	echo "$(tput setaf 6)-----Attaching into existing $container_name-----$(tput sgr0)"
	echo "$(tput setaf 6)*************************************$(tput sgr0)"
    sudo docker exec -i -t \
		$container_name \
		/bin/bash

    exit 0
fi

start_docker(){

	local name=$1
	docker_args+=("-e NVIDIA_DRIVER_CAPABILITIES=all")
	docker_args+=("-e NVIDIA_VISIBLE_DEVICES=all")
	sudo docker run -it --privileged --rm \
				--gpus all \
				--net=host \
				--env="DISPLAY"\
				-e VARDPY=$VARDPY -e VARPROTO=$VARPROTO -e VARHEX=$VARHEX \
				"${docker_args[@]}" \
				-v ~/Documents/docker_storage/$container_name:/home/ \
				--device=/dev/dri:/dev/dri \
				--entrypoint='' \
				--name="$container_name" ros:"$name" \
				/bin/bash

}

docker_args=()

if [ ! -z "$device_type" ];then
	start_docker "$distro_name-$device_type"
	
else
	start_docker "$distro_name"

fi
