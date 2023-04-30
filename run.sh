xhost +local:root
docker run -it --rm -e DISPLAY=$DISPLAY \
  --network host \
  -e DISPLAY=$DISPLAY \
  -v $HOME/.Xauthority:/root/.Xauthority \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
   -v $(pwd)/bags:/bags \
  --name livox_noetic livox-noetic
