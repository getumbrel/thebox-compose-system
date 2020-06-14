#!/bin/bash -e

echo "==== OTA UPDATE ===== | STAGE: INSTALL UPDATE"

RELEASE="v0.1.1"

echo "Installing Umbrel $RELEASE"

# Clone new dir tree
echo "Cloning repository"
git clone https://github.com/getumbrel/umbrel-compose.git /tmp/new-dir-tree

# Checkout to the new release
cd /tmp/new-dir-tree
git fetch --all --tags
git checkout tags/$RELEASE

echo "Removing unwanted stuff"
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
echo "Pulling new images"
HOME=/home/umbrel docker-compose --file /tmp/new-dir-tree/docker-compose.yml pull

# Stop existing containers
echo "Stopping existing containers"
HOME=/home/umbrel docker-compose --file /home/umbrel/docker-compose.yml down

# Overlay home dir structure with new dir tree
echo "Overlaying /home/umbrel/ with new directory tree"
rsync -av /tmp/new-dir-tree/ --exclude='.*' /home/umbrel/

# Update RPC Password in docker-compose.yml
echo "Updating RPC Password in docker-compose.yml"
RPCPASS=`cat /home/umbrel/secrets/rpcpass.txt`
sed -i "s/RPCPASS/${RPCPASS}/g;" /home/umbrel/docker-compose.yml

# Fix permissions
echo "Fixing permissions"
chown -R umbrel:umbrel /home/umbrel

# Start updated containers
echo "Starting new containers"
HOME=/home/umbrel docker-compose --file /home/umbrel/docker-compose.yml up --detach --remove-orphans