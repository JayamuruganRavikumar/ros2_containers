
## Building a ros docker image

- `cd into the build folder`. Add the Dockerfiles here.

- Change the working directory if needed in the build.sh file, default will be `~/Documents/docker_storage/ros-<distro name>`

## Running Containers

- Run `./build.sh <ros distro name> <1>` (foxy, humble, galactic) (1 pulls nvidia/cuda image, Leaving it empty pulls from ros:distro).

- After build is finished run `./ros.sh <distro name> <1>` will open a interactive shell with GUI support in linux. Passing `1` will notifiy docker to use the nvidia image.

- Reruning the `./ros.sh <distro name> <1>` will attach a container.

- add `alias launchDocker="zsh ~/Documents/automationFiles/docker/ros.sh"` to your bashrc/zshrc to launch your container with `launchDocker <distro name> <1>`.

### Jetsons

To run containers on jetons use [jetson-containers](https://github.com/dusty-nv/jetson-containers.git) package.

- Follow the [setup guide](https://github.com/dusty-nv/jetson-containers/blob/master/docs/setup.md) to install and setup ssd as a storage for the containers. 
- To run a container image use `jetson-containers run --volume /home/user/Documents/docker_storage/ros-humble:/home container:tag`
- You can change the run command in the `run.sh` in the package files.

