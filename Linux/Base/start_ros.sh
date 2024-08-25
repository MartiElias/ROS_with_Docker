# --rm -> will delete the container once it is stopped
# -it -> interactive tty terminal
# -v -> mount X11 socket for GUI applications
# -v -> mount local ./src directory to /home/ros-foxy/src in the container
# -e -> environment: set DISPLAY variable for X11 forwarding
# --network -> host: use the host's network stack
# --name -> ros: name the container 'ros'
# image -> run the 'my_ros_foxy' image

docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -v ./src:/home/ros-foxy/src -e DISPLAY=${DISPLAY} --network host --name ros my_ros_foxy