#!/bin/bash -e

echo "This script runs to install the update"

RELEASE="v0.1.1"

# Clone new dir tree
git clone https://github.com/getumbrel/umbrel-compose.git /tmp/new-dir-tree

# Checkout to the new release
cd /tmp/new-dir-tree
git fetch --all --tags
git checkout tags/$RELEASE

# Remove unwanted stuff
rm -rf .git
rm -f README.md
rm -f LICENSE
rm -f install-box.sh
rm -f configure-box.sh
rm -f CONTRIBUTING.md
rm -f .gitignore
rm -rf bitcoin
rm -rf lnd
rm -rf db
rm -rf secrets

# Pull new images
docker-compose --file /tmp/new-dir-tree/docker-compose.yml pull

# Stop existing containers
docker-compose --file /home/$USER/docker-compose.yml down

# Overlay home dir structure with new dir structure
rsync -av /tmp/new-dir-tree/ --exclude='.*' /home/$USER/

# Start updated containers
docker-compose --file /home/$USER/docker-compose.yml up --detach --remove-orphans

# Delete previous (unused) images
docker image prune --all --force