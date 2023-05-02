xhost +local:root
docker run -it -e DISPLAY=$DISPLAY \
  --network host \
  -e DISPLAY=$DISPLAY \
  -v $HOME/.Xauthority:/root/.Xauthority \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
   -v $(pwd)/bags:/bags \
   --privileged \
  --name livox_noetic livox-noetic
