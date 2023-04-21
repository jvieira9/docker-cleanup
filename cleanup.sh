#!/bin/bash
# 2023 - By: João Vieira | 'jvieira9' on GitHub
# This script cleans your Docker ecosystem.

# This enables the script to exit immediately if there is an error.
set -euo pipefail

# Check if the docker command is installed
if ! command -v docker >/dev/null 2>&1; then 
    printf "Error: Docker is not installed. Aborting.\n"
    exit 1
fi

# >/dev/null: redirects standard output to the null device
# 2>&1: redirects standard error to the same place as standard output, which is the null device

# Command to avoid a permission error.
sudo chmod 666 /var/run/docker.sock >/dev/null 2>&1

# Prompt to confirm if the user wants to proceed
read -p "This script will clean your docker ecosystem. Do you want to continue? [Y/n]" clean_docker
if [[ $clean_docker == [yY] || $clean_docker == "" ]]; then
    printf "Cleaning your Docker ecosystem...\n"
else
    printf "Aborting.\n"
    exit 1
fi

# Check if there are containers to stop
if [[ $(docker ps -q) ]]; then
    # Stop all running containers
    printf "Stopping all running containers...\n"
    if docker stop $(docker ps -q) >/dev/null 2>&1; then
        printf "All running containers stopped successfully.\n"
    else
        printf "Failed to stop running containers.\n"
    fi
else
    # There are no containers to stop
    printf "There are no running containers to stop.\n"
fi

# Check if there are containers to delete
if [[ $(docker ps -aq) ]]; then
    # Delete all containers
    printf "Deleting all containers...\n"
    if docker rm -f $(docker ps -aq) >/dev/null 2>&1; then
        printf "All containers deleted successfully.\n"
    else
        printf "Failed to delete all containers.\n"
    fi
else
    # There are no containers to delete
    printf "There are no containers to delete.\n"
fi

# Check if there are images to delete
if [[ $(docker images -aq) ]]; then
    # Delete all images
    printf "Deleting all images...\n"
    if docker rmi -f $(docker images -aq) >/dev/null 2>&1; then
        printf "All images deleted successfully.\n"
    else
        printf "Failed to delete all images.\n"
    fi
else
    # There are no images to delete
    printf "There are no images to delete.\n"
fi

# Check if there are volumes to delete
if [[ $(docker volume ls -q) ]]; then
    # Delete all volumes
    printf "Deleting all volumes...\n"
    if docker volume rm $(docker volume ls -q) >/dev/null 2>&1; then
        printf "All volumes deleted successfully.\n"
    else
        printf "Failed to delete all volumes.\n"
    fi
else
    # There are no volumes to delete
    printf "There are no volumes to delete.\n"
fi

# Check if there are custom networks to delete
if [[ $(docker network ls -q --filter type=custom) ]]; then
    # Delete all custom networks
    printf "Deleting all custom networks...\n"
    if docker network rm $(docker network ls -q --filter type=custom) >/dev/null 2>&1; then
        printf "All custom networks deleted successfully.\n"
    else
        printf "Failed to delete all custom networks.\n"
    fi
else
    # There are no custom networks to delete
    printf "There are no custom networks to delete.\n"
fi

printf "Docker ecosystem cleaned successfully.\n"
exit 0