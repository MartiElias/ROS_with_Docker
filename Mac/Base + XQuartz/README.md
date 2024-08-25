Steps to Set Up XQuartz and Docker for GUI Programs
1. Install XQuartz
If you haven’t already installed XQuartz, download it from xquartz.org, and follow the installation instructions.

2. Start XQuartz
Launch XQuartz from your Applications folder or by running the following command in your terminal:
bash
Copiar código
open -a XQuartz
Go to XQuartz > Preferences > Security and check the box that says:
"Allow connections from network clients"
3. Enable xhost
In the terminal, allow Docker to connect to your X server by running:

bash
Copiar código
xhost +
This command allows any client (including your Docker container) to connect to your X server.

4. Run Docker with X11
./start_ros_xterm.sh