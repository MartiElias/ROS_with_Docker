# docker exec -> Executes a command in a running container
# -it -> Flags to run the command interactively with a TTY (terminal), allowing you to interact with the container
# ros -> The name of the container to connect to (in this case, 'ros')
# /bin/bash -> The command to run inside the container, which in this case is launching the Bash shell

docker exec -it ros /bin/bash
