FROM osrf/ros:foxy-desktop

# Add vscode user with same UID and GID as your host system
# (copied from https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#_creating-a-nonroot-user)
ARG USERNAME=ros-foxy
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch from root to user
USER $USERNAME

# Add user to video group to allow access to webcam
RUN sudo usermod --append --groups video $USERNAME

# Update all packages
RUN sudo apt update && sudo apt upgrade -y

# Install Git, vim, and nano
RUN sudo apt install -y git vim nano

# Gazebo
RUN sudo apt update && sudo apt upgrade -y
RUN sudo apt install -y ros-foxy-gazebo-ros-pkgs

# Rosdep update
RUN sudo rosdep update

# Source the ROS setup file
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

# Switch back to root to copy and run the script
USER root

# Desktop-lite
COPY library-scripts/desktop-lite-debian.sh /tmp/library-scripts/
RUN apt update && bash /tmp/library-scripts/desktop-lite-debian.sh

# Set environment variables
ENV DBUS_SESSION_BUS_ADDRESS="autolaunch:" \
    VNC_RESOLUTION="1440x768x16" \
    VNC_DPI="96" \
    VNC_PORT="5901" \
    NOVNC_PORT="6080" \
    DISPLAY=":1" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8"

# Switch back to non-root user
USER $USERNAME

ENTRYPOINT ["/usr/local/share/desktop-init.sh"]
CMD ["sleep", "infinity"]
