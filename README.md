# Docker Cleanup Script

This repository contains a bash script designed to clean up your Docker ecosystem.

## Author

2023 - By João Vieira | `jvieira9` on [GitHub](https://github.com/jvieira9)

### Script - cleanup.sh

This script cleans up your Docker ecosystem, including:

- All running containers;
- All images;
- All volumes;
- All custom networks.

### Functionality

1. The script checks if Docker is installed and exits if it isn't;
2. The script prompts the user to confirm whether they want to proceed with the cleaning process;
3. The script checks if there are any containers, images, volumes, or custom networks to delete;
4. The script proceeds to stop and delete all running containers, delete all images, delete all volumes, and delete all custom networks;
5. If any errors occur during the execution of the script, an error message is displayed, and the script is aborted.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Getting Started

To execute the script on your machine, follow these steps:

1. Clone this repository to your local machine using the command:

    ```
    git clone https://github.com/jvieira9/docker-cleanup.git
    ```
    or
    ```
    git clone git@github.com:jvieira9/docker-cleanup.git
    ```

2. Navigate to the directory where the repository was cloned using the command:

    ```
    cd docker-cleanup
    ```

3. Modify the permissions of the script before executing it. To do this, run the following command: 

    ```
    chmod +x cleanup.sh
    ```

4. Run the following command to execute the script: 

    ```
    ./cleanup.sh
    ```

## Notes

- This script requires Docker to be installed on your system. If Docker is not installed, the script will display an error message and exit.
- This script requires sudo permissions to run.

#### If you encounter any issues while executing this script, please feel free to contact me at `joao.lopes.vieira115@gmail.com`.