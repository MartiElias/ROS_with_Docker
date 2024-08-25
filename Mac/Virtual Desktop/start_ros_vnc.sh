# ///// Start the Docker container /////
# --rm -> remove the Docker container once it's stopped
# -d -> run the container in the background (detached mode)
# -e "TERM=xterm-256color" -> environment variable to enable colored output in the terminal (user and @host name)
# -p 5901:5901 -> map port 5901 on the host to port 5901 in the container for VNC service
# -p 6080:6080 -> map port 6080 on the host to port 6080 in the container for noVNC connection (access via localhost:6080)
# -v ./catkin_ws:/home/ros-foxy/catkin_ws -> bind mount the host's "catkin_ws" directory to "/home/ros-foxy/catkin_ws" in the container
# --name ros -> assign the name 'ros' to the container
docker run --rm -d -e "TERM=xterm-256color" -p 5901:5901 -p 6080:6080 -v ./catkin_ws:/home/ros-foxy/catkin_ws --name ros my_foxy

# ///// Connect to the running container /////
# exec -> run a command in a running container
# -it -> interactive terminal (with TTY) to allow interaction with the container
# ros -> container name
# /bin/bash -> shell to run inside the container
docker exec -it ros /bin/bash
