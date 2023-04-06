#!/bin/bash
# 2023 - By: João Vieira | 'jvieira9' on GitHub
# This script cleans your Docker ecosystem.

# This enables the script to exit immediately if any command fails
set -euo pipefail

# Check if the docker command is installed
if ! command -v docker >/dev/null 2>&1; then
    printf "Error: Docker is not installed. Aborting.\n" >&2
    exit 1
fi

# Command to avoid an error
sudo chmod 666 /var/run/docker.sock >/dev/null 2>&1

# Trap errors and display error message
on_error() {
    local exit_code="$?"
    printf "Error: An error occurred in the script. Aborting.\n" >&2
    exit "$exit_code"
}
trap on_error ERR

read -p "This script will stop and delete all running containers, delete all images, delete all volumes, and delete all custom networks. Do you want to continue? [y/N] " answer
if [[ $answer != "y" ]]; then
    printf "Aborting.\n"
    exit 1
else
    printf "Cleaning your Docker ecosystem...\n"
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
        printf "Failed to delete containers.\n"
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
        printf "Failed to delete images.\n"
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
        printf "Failed to delete volumes.\n"
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
        printf "Failed to delete custom networks.\n"
    fi
else
    # There are no custom networks to delete
    printf "There are no custom networks to delete.\n"
fi

printf "Docker ecosystem cleaned successfully.\n"