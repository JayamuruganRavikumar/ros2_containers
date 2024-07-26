
## Building a ros docker image

- `cd into the build folder`. Add the Dockerfiles here.

- Change the working directory if needed in the build.sh file, default will be `~/Documents/docker_storage/ros-<distro name>`

- Run `./build.sh <ros distro name> <1>` (foxy, humble, galactic) (1 pulls nvidia/cuda image, Leaving it empty pulls from ros:distro).

- After build is finished run `./ros.sh <distro name> <1>` will open a interactive shell with GUI support in linux. Passing `1` will notifiy docker to use the nvidia image.

- Reruning the `./ros.sh <distro name> <1>` will attach a container.

- add `alias launchDocker="zsh ~/Documents/automationFiles/docker/ros.sh"` to your bashrc/zshrc to launch your container with `launchDocker <distro name> <1>`.

