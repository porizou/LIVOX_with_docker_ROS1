# LIVOX_with_docker_ROS1

Dockerfile to run LIVOX and SLAM packages with Docker.

# Use Repositories

livox_ros_driver2

https://github.com/Livox-SDK/livox_ros_driver2

Livox-SDK2

https://github.com/Livox-SDK/Livox-SDK2

FAST-LIO

https://github.com/michalpelka/FAST_LIO

# Change IP address in dockerfile

IP address settings for PC and LIVOX
Edit Dockerfile or set in build arguments

```txt:Dockerfile
ARG LIVOX_IP=192.168.1.160
ARG PC_IP=192.168.1.100
```

# Build 

LIVOX_IP : IP address of LIVOX  
PC_IP : IP address of PC  
ROS_DISTRO :  ROS1 Distribution

ROS Melodic

```bash
docker build --build-arg ROS_DISTRO=melodic --build-arg LIVOX_IP=192.168.1.160 --build-arg PC_IP=192.168.1.100 -t livox-melodic -f Dockerfile .
```

ROS Noetic

```bash
docker build --build-arg ROS_DISTRO=noetic --build-arg LIVOX_IP=192.168.1.160 --build-arg PC_IP=192.168.1.100 -t livox-noetic -f Dockerfile .
```


# RUN

```bash
xhost +local:root
docker run -it --rm -e DISPLAY=$DISPLAY \
  --gpus all \
  --network host \
  -e DISPLAY=$DISPLAY \
  -v $HOME/.Xauthority:/root/.Xauthority \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --name livox_melodic livox-melodic
```

