# --rm: Automatically remove the container once it stops
# -it: Run the container in interactive mode with a TTY (for shell access)
# --gpus all: Allow the container to use all available GPUs (requires NVIDIA drivers and Docker's GPU support)
# -e DISPLAY=:0: Set the DISPLAY environment variable to use the local X server for GUI applications (WSL2 uses :0 for display)
# -v /mnt/wslg/.X11-unix:/tmp/.X11-unix:rw: Mount the X11 socket from WSLg for GUI forwarding
# --name ros: Name the container 'ros'
# -e "TERM=xterm-256color": Set terminal type to xterm-256color for better terminal rendering
# -v /mnt/c/Users/USERNAME/src:/home/ros-foxy/src: Mount the local Windows directory (via WSL) to the container's /home/ros-foxy/src directory
# my_foxy: Use the 'my_foxy' Docker image to run the container

docker run --rm -it --gpus all -e DISPLAY=:0 -v /mnt/wslg/.X11-unix:/tmp/.X11-unix:rw --name ros -e "TERM=xterm-256color" -v /mnt/c/Users/USERNAME/src:/home/ros-foxy/src my_foxy
