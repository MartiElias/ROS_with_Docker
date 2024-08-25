# ///// Start the docker container /////
# --rm -> Automatically remove the Docker container once it's stopped
# -d -> Run the container in the background (detached mode)
# -e "TERM=xterm-256color" -> Set environment variable to improve terminal colors (helps with readability of the user and @ name)
# -p 5901:5901 -> Open port 5901 for VNC service
# -p 6080:6080 -> Open port 6080 for noVNC connection on localhost:6080
# -v /mnt/c/Users/USERNAME/src:/home/ros-foxy/src -> Mount the local directory "src" from the Windows file system to the container's "/home/ros-foxy/src"
# --name ros -> Assign the container the name 'ros'
docker run --rm -d -e "TERM=xterm-256color" -p 5901:5901 -p 6080:6080 -v /mnt/c/Users/USERNAME/src:/home/ros-foxy/src --name ros my_foxy

# ///// Connect to the container /////
# exec -> Attach to a running container
# -it -> Enable interactive mode with a TTY terminal
# ros -> The name of the running container
docker exec -it ros /bin/bash
