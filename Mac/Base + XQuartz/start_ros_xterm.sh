# --rm -> will delete the container once it is stopped
# -it -> interactive tty terminal
# -e -> environment: set TERM variable for better terminal color support
# -v -> mount local catkin_ws directory to /home/ubuntu/catkin_ws in the container
# --name -> ros: name the container 'ros'
# -e -> environment: set DISPLAY for X11 forwarding to host
# -v -> mount X11 socket to allow GUI applications
# image -> run the 'my_foxy' image

docker run --rm -it -e "TERM=xterm-256color" -v ./catkin_ws:/home/ubuntu/catkin_ws --name ros -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix my_foxy
