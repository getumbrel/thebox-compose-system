#!/bin/bash -e

echo "This script runs on error"

# Stop any running containers
docker-compose --file /home/$USER/docker-compose.yml down

# Revert to previous home dir tree + delete anything that wasn't a part of prev tree
rsync -av /tmp/prev_dir_tree/ /home/$USER/ --delete

# Start updated services
docker-compose --file /home/$USER/docker-compose.yml up --detach --remove-orphans

# Delete all unused images
docker image prune --all --force