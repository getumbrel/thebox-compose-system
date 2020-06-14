#!/bin/bash -e

echo "==== OTA UPDATE ===== | STAGE: ERROR"

# Stop any running containers
echo "Stopping all running containers"
HOME=/home/umbrel docker-compose --file /home/umbrel/docker-compose.yml down

# Revert to previous home dir tree (if exists) + delete anything that wasn't a part of prev tree
echo "Reverting to previous /home/umbrel/ directory tree"
[ -d /tmp/prev-dir-tree ] && rsync -av /tmp/prev-dir-tree/ /home/umbrel/ --delete

# Fix permissions
echo "Fixing permissions"
chown -R umbrel:umbrel /home/umbrel

# Start updated services
echo "Starting previous containers"
HOME=/home/umbrel docker-compose --file /home/umbrel/docker-compose.yml up --detach --remove-orphans