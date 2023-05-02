ARG ROS_DISTRO=noetic
ARG LIVOX_IP=192.168.1.160
ARG PC_IP=192.168.1.100

FROM osrf/ros:$ROS_DISTRO-desktop-full

# キーボード設定の選択を聞かれないようにする
ARG DEBIAN_FRONTEND=noninteractive

# よく使うapt のパッケージをインストール
RUN apt-get update && apt-get install -y \
git \
vim \
wget \
tmux \
build-essential  \
screen \
iputils-ping \
net-tools \ 
pcl-tools \
v4l-utils \
ffmpeg \
terminator && \
apt-get clean && rm -rf /var/lib/apt/lists/*

# ROSのパッケージのインストール
RUN apt-get update && apt-get install -y \
    ros-$ROS_DISTRO-perception-pcl ros-$ROS_DISTRO-rviz ros-$ROS_DISTRO-eigen-conversions \
    ros-$ROS_DISTRO-usb-cam \
    ros-$ROS_DISTRO-image-view && \
    rm -rf /var/lib/apt/lists/* 

# LIVOX-SDKのインストール
RUN git clone https://github.com/Livox-SDK/Livox-SDK2.git && \
    mkdir -p ./Livox-SDK2/build && \
    cd ./Livox-SDK2/build && \
    cmake .. && make -j && make install
# livox-ros-driver2のインストール
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    mkdir -p /ws/src && \ 
    cd /ws/src && \
    git clone https://github.com/Livox-SDK/livox_ros_driver2.git && \
    cd /ws/src/livox_ros_driver2 && ./build.sh ROS1
# FAST-LIOのインストール
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    cd /ws/src && \
    git clone https://github.com/michalpelka/FAST_LIO.git -b livox_sdk2 && \
    cd FAST_LIO && git submodule init && git submodule update

RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    cd /ws && catkin_make
# IPアドレスの設定
RUN sed -i "s/192.168.1.12/192.168.1.160/g" /ws/src/livox_ros_driver2/config/MID360_config.json
RUN sed -i 's/192.168.1.5/192.168.1.100/g' /ws/src/livox_ros_driver2/config/MID360_config.json 

RUN echo ". /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx libgl1-mesa-dri && \
    rm -rf /var/lib/apt/lists/*
    
ENV LIBGL_ALWAYS_SOFTWARE=1 
