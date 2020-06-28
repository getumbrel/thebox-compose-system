  
#!/bin/bash -e

RELEASE=$1
UMBREL_DIR=$2

echo "==== OTA UPDATE ===== | STAGE: INSTALL UPDATE"

# Checkout to the new release
cd /tmp/umbrel-$RELEASE

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
rm -rf tor
rm -rf secrets

# Update RPC Password in docker-compose.yml
echo "Updating RPC Password in docker-compose.yml"
RPCPASS=`cat $UMBREL_DIR/secrets/rpcpass.txt`
sed -i "s/RPCPASS/${RPCPASS}/g;" docker-compose.yml

# Pull new images
echo "Pulling new images"
docker-compose --file /tmp/umbrel-$RELEASE/docker-compose.yml pull

# Stop existing containers
echo "Stopping existing containers"
docker-compose --file $UMBREL_DIR/docker-compose.yml down

# Overlay home dir structure with new dir tree
echo "Overlaying $UMBREL_DIR/ with new directory tree"
rsync -av /tmp/umbrel-$RELEASE/ --exclude='.*' $UMBREL_DIR/

# Fix permissions
echo "Fixing permissions"
chown -R $USER:$USER $UMBREL_DIR

# Start updated containers
echo "Starting new containers"
docker-compose --file $UMBREL_DIR/docker-compose.yml up --detach --remove-orphans