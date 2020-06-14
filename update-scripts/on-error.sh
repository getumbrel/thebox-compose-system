#!/bin/bash -e

echo "==== OTA UPDATE ===== | STAGE: ERROR"

# Stop any running containers
echo "Stopping all running containers"
docker-compose --file /home/umbrel/docker-compose.yml down

# Revert to previous home dir tree (if exists) + delete anything that wasn't a part of prev tree
echo "Reverting to previous /home/umbrel/ directory tree"
[ -d /tmp/prev-dir-tree ] && rsync -av /tmp/prev_dir_tree/ /home/umbrel/ --delete

# Start updated services
echo "Starting previous containers"
docker-compose --file /home/umbrel/docker-compose.yml up --detach --remove-orphans