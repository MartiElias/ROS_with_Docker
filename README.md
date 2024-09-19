# ROS_with_Docker

Welcome to the `ROS_with_Docker` project! This repository is designed to help users easily install and use the Robot Operating System (ROS) through Docker containers, providing a consistent and hassle-free environment for ROS development across different platforms—Linux, Mac, and Windows.

This repository is set up to use **ROS Foxy** as the default ROS version. If you would like to use a different version of ROS, such as **ROS Noetic** or **ROS Humble**, you can modify the `Dockerfile` in the corresponding directory for your operating system.

## How to Change the ROS Version

To change the ROS version being used, open the `Dockerfile` in the appropriate directory (Linux, Mac, or Windows) and update the line that specifies the ROS version. For example, if you want to change from ROS Foxy to ROS Noetic:

```dockerfile
FROM ros:foxy
FROM ros:noetic
````

# Notes:
If you are using an ARM device like a Raspberry Pi, the ROS version is different. In this case, the base image should be `FROM arm64v8/ros:foxy`.

If you're looking to use older versions of ROS, like ROS Kinetic, please check out [this repository](https://github.com/MartiElias/ROS_Kinetic_VNC_Docker). It provides Docker support for ROS Kinetic with VNC for graphical access, ideal for systems running Ubuntu 16.04 or needing a containerized ROS Kinetic environment.

## Alternative Solution: VS Code Docker Extension

If you prefer not to work directly with Docker commands and configurations, or if you are looking for a more user-friendly option, consider using the **Visual Studio Code Docker Extension**. This extension simplifies container management and integration directly from the editor. It might be a better solution for your case if you want to avoid manually handling Docker configurations.

You can find more information and installation instructions for the VS Code Docker Extension [here](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker).

Video recommendation:
https://www.youtube.com/watch?v=dihfA7Ol6Mw&t=234s


## Repository Structure

This repository is organized into three main folders, each corresponding to an operating system:

- **Linux/**
- **Mac/**
- **Windows/**

Each folder contains platform-specific Docker configurations and scripts for setting up and running ROS. Below is an overview of the contents within each folder.

### Linux

The `Linux/` directory contains two main subfolders and one file, which are:

- **Dockerfile**: The Dockerfile used to build a base ROS environment for Linux.
  
- **Base/**:
  - `start_ros.sh`: A script to start the ROS container without GPU access.
  - `connect_ros.sh`: Script to connect to the running ROS container with an interactive terminal session.

- **nvidia/**:
  - `Install_Docker_nvidia.pdf`: A guide for installing Docker with NVIDIA support, tailored for those with NVIDIA GPUs.
  - `start_ros_nvidia.sh`: A script to start the ROS container with GPU access for systems equipped with an NVIDIA graphics card.
  - `connect_ros.sh`: Script to connect to the running ROS container with an interactive terminal session.

> **Note**: The `Base/` folder runs ROS without GPU access, making it suitable for systems without a dedicated GPU. The `nvidia/` folder is specifically designed for systems with an NVIDIA GPU and leverages Docker s GPU access for accelerated performance in ROS.  
> Unfortunately, at the moment, support for AMD GPUs is not available in this repository, as I do not have access to an AMD card for testing and implementation.
  
#### Graphics Support in Linux

Since Linux shares the same graphical environment with the Docker container, you will have direct access to graphical applications such as **RViz2** simply by typing the command within the container. No additional setup is needed for displaying these applications outside the container.

> **Note**: Some applications, such as **Gazebo**, might display very small on 4K monitors. This is due to scaling issues with high-resolution screens. A simple solution is to reduce the resolution of your PC before running these applications in the container to improve the display scaling.


### Mac

The `Mac/` directory is structured into three subfolders, each designed to provide different levels of functionality for running ROS on Mac systems. Below is an explanation of each folder:

- **Virtual Desktop/**:
  - This setup allows Mac users to access graphical applications such as **RViz** and **Gazebo** through a virtual desktop environment. The virtual desktop is served using **noVNC**, enabling users to interact with ROS applications via their web browser at `localhost:6080`.
  - By default, the password for accessing the virtual desktop is set to `vscode`.
  - The virtual desktop package is provided by Josh Spicer and can be found in the following GitHub repository: [desktop-lite-debian.sh](https://github.com/microsoft/vscode-dev-containers/blob/main/script-library/desktop-lite-debian.sh).
  - **Contents**:
    - `Dockerfile`: Used to build the virtual desktop environment.
    - `start_ros_vnc.sh`: A script to start the ROS container with VNC access.
    - `connect_ros.sh`: Script to connect to the running ROS container with an interactive terminal session.
    - `stop_ros.sh`: A script to stop the ROS container.
    - `library-scripts/`: This folder contains entry-point scripts for configuring the VNC and noVNC environments.

- **Base/**:
  - This folder provides a setup for running ROS on Mac, but **without support for graphical applications**. Since macOS does not natively have the same graphical compatibility that Linux-based systems have, applications like RViz and Gazebo cannot be run in this setup.
  - **Contents**:
    - `Dockerfile`: Used to build a basic ROS environment without GUI support.
    - `start_ros.sh`: A script to start the ROS container.
    - `connect_ros.sh`: Script to connect to the running ROS container with an interactive terminal session.

- **Base + XQuartz/**:
  - This folder offers an improvement over the `Base` setup by allowing users to run **basic GUI applications** such as **rqt** and simulations like **TurtleBot Sim**. However, applications like **RViz** and **Gazebo** are not supported in this environment.
  - The `Base + XQuartz` setup is ideal for users who want to go through all the beginner tutorials of ROS, as it provides enough GUI functionality for those purposes without the complexity of full graphical applications.
  - **Contents**:
    - `Dockerfile`: Used to build the ROS environment with XQuartz support for basic GUI applications.
    - `start_ros_xterm.sh`: A script to start the ROS container with XQuartz support.
    - `connect_ros.sh`: Script to connect to the running ROS container with an interactive terminal session.
    - `README.md`: Documentation specifically for using ROS with XQuartz on Mac.

#### Network Limitations on macOS

Unfortunately, **Docker on macOS does not have access to the `--network host` mode** as it does on Linux. By default, Docker for Mac operates using a NAT network, meaning that Docker containers are isolated from the host s network and cannot directly access other devices on your local network. The containers receive their own IP addresses from a sub-network created by Docker, and external devices cannot directly access the containers unless specific ports are explicitly exposed.

While direct access to the host network is not supported (due to the lack of `--network host` mode on Docker for Mac), you can use `host.docker.internal` to allow the containers to communicate with services running on the host machine. Additionally, you can use port forwarding to expose services running in the containers to external devices on your network.

This limitation restricts ROS communication primarily to within the container and the host machine. As a result, ROS nodes inside the container cannot easily be accessed by other devices on your local network unless ports are explicitly forwarded. If your project requires seamless network communication across multiple devices, this constraint should be considered when using Docker on macOS.


### Windows

The `Windows/` directory is structured similarly to the Mac directory but without the `Base + XQuartz` folder. Below is an explanation of each folder:

- **Virtual Desktop/**:
  - This setup allows Windows users to access graphical applications such as **RViz** and **Gazebo** through a virtual desktop environment. The virtual desktop is served using **noVNC**, enabling users to interact with ROS applications via their web browser at `localhost:6080`.
  - By default, the password for accessing the virtual desktop is set to `vscode`.
  - The virtual desktop package is provided by Josh Spicer and can be found in the following GitHub repository: [desktop-lite-debian.sh](https://github.com/microsoft/vscode-dev-containers/blob/main/script-library/desktop-lite-debian.sh).
  - **Contents**:
    - `Dockerfile`: Used to build the virtual desktop environment.
    - `start_ros_vnc.sh`: A script to start the ROS container with VNC access.
    - `connect_ros.sh`: Script to connect to the running ROS container with an interactive terminal session.
    - `stop_ros.sh`: A script to stop the ROS container.
    - `library-scripts/`: This folder contains entry-point scripts for configuring the VNC and noVNC environments.

- **Base/**:
  - This folder provides a setup for running ROS on Windows, with support for graphical applications if run through **WSL2** (Windows Subsystem for Linux 2). Unlike traditional Windows Docker setups, **WSL2** allows you to leverage the native Linux kernel and GPU passthrough, enabling graphical applications such as **RViz** and **Gazebo** to run inside the container.
  - **Contents**:
    - `Dockerfile`: Used to build a basic ROS environment with support for graphical applications via WSL2.
    - `start_ros.sh`: A script to start the ROS container.
    - `connect_ros.sh`: A script to connect to the running ROS container with an interactive terminal session.

> **Note**: Graphical applications such as **RViz** and **Gazebo** can be run in this setup only when using WSL2, which allows access to the X11 display server for GUI rendering.

> **Note nvidia**: Although I have successfully connected the NVIDIA drivers and verified it with `nvidia-smi` inside the container, the GPU is not being assigned properly to the container during runtime. This means that while the drivers are recognized, the GPU might not be fully utilized for tasks like simulation or computation within the container. I will continue to work on this issue and hope to fully implement GPU support in the future.


#### Network Limitations on Windows

Docker on Windows also **does not support the `--network host` mode** as it does on Linux. By default, Windows Docker containers operate on a NAT network, where the container receives an IP address from a sub-network created by Docker. This means the containers cannot directly access other devices on your local network, and similarly, external devices cannot access the containers without explicitly published ports.

To work around this limitation, you can expose specific ports using the `-p` flag when running containers. Alternatively, you can use a **transparent network** which allows containers to get IP addresses from the same network as your host, behaving more like standard networked devices. Keep in mind that this method may have additional configuration requirements and is not supported in all environments, such as Azure VMs&#8203;:contentReference[oaicite:0]{index=0}.

For simple local development, you can use `host.docker.internal` to allow containers to communicate with services running on the Windows host machine&#8203;:contentReference[oaicite:1]{index=1}.


## Usage

1. **Choose your operating system**: Navigate to the folder corresponding to your OS—Linux, Mac, or Windows.

   > **Windows Users**: Make sure to manually create the folder you want to mount to your container (e.g., `catkin_ws`) before running the Docker command. If the folder does not exist, Docker will crash when attempting to connect it to the container.

2. **Follow the installation steps**: Each folder contains Dockerfiles and scripts specifically tailored to setting up ROS on your OS. For special cases like NVIDIA GPU support or XQuartz, refer to the additional folders in Linux and Mac respectively.
3. **Build the docker image with:
   > docker build -t image_name .

   > **Note**: Before running the scripts, make sure they have executable permissions. You can grant these permissions by running:
   > 
   > chmod +x file.sh
   > 
   > Replace `file.sh` with the name of the script you want to make executable (e.g., `chmod +x start_ros.sh`).

   >**Note**: it windows you may need to use sudo. sudo build -t image_name .

  > **Important for Virtual Desktop Users**: If you are using a virtual desktop setup and the base setup, it is essential to rename your Docker image at list in one of it, to avoid conflicts. After building your custom image, make sure to update the image name in all relevant `.sh` scripts (e.g., `start_ros.sh`). 
  >
  > Failure to rename the image can cause the base image to stop working, leading to issues in your environment. Always use a unique image name when working with virtual desktops to prevent these conflicts.

4. **Run the scripts**: Use the provided `start_ros.sh`, `start_ros_vnc.sh`, or `start_ros_xterm.sh` to start your ROS environment.
  > **Important: Check the `.sh` Files Before Running
  > Before running the provided `.sh` files, please open and review them to ensure they are configured correctly for your environment. Most of the scripts should run properly out of the box, but you may need to make a few tweaks depending on your setup.

5. **Connecting to the ROS Container: If you need additional terminals connected to the same ROS environment, use the ros_connect.sh script. This will open a new terminal session within the running container.
6. **Stopping the Container: 
  - When you exit the container (either by typing exit or using Ctrl+D), the container will be automatically deleted due to the --rm flag used during startup.
  - If you are running a virtual desktop environment, make sure to stop the container using the `stop_ros.sh
7. **Understanding the Scripts: Each script is thoroughly commented to help you understand the commands being executed. Feel free to open the scripts in any text editor for a deeper look into how they work.

## Prerequisites

- **Docker**: Make sure Docker is installed and running on your system. Instructions can be found on the [official Docker website](https://docs.docker.com/get-docker/).
- **NVIDIA GPU support (Linux)**: For users with NVIDIA GPUs, follow the steps in the `nvidia/Install_Docker_nvidia.pdf` guide to set up GPU support for your ROS environment.

## Contributing

Feel free to contribute by submitting issues or pull requests. Whether its adding new scripts, improving the documentation, or enhancing cross-platform compatibility, all contributions are welcome!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

Please note that the file `desktop-lite-debian.sh` was originally developed by Microsoft Corporation and is also licensed under the MIT License. For details, refer to the original license notice within the file.
