  
#!/bin/bash -e

RELEASE=$1
UMBREL_DIR=$2

echo "==== OTA UPDATE ===== | STAGE: INSTALL UPDATE"
cat <<EOF > $UMBREL_DIR/status.json
{"state": "installing", "progress": 33, "description": "Configuring files"}
EOF

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
cat <<EOF > $UMBREL_DIR/status.json
{"state": "installing", "progress": 40, "description": "Pulling new Docker images"}
EOF
docker-compose --file /tmp/umbrel-$RELEASE/docker-compose.yml pull

# Stop existing containers
echo "Stopping existing containers"
cat <<EOF > $UMBREL_DIR/status.json
{"state": "installing", "progress": 70, "description": "Stopping existing containers"}
EOF
docker-compose --file $UMBREL_DIR/docker-compose.yml down

# Overlay home dir structure with new dir tree
echo "Overlaying $UMBREL_DIR/ with new directory tree"
rsync -av /tmp/umbrel-$RELEASE/ --exclude='.*' $UMBREL_DIR/

# Fix permissions
echo "Fixing permissions"
chown -R $USER:$USER $UMBREL_DIR

# Start updated containers
echo "Starting new containers"
cat <<EOF > $UMBREL_DIR/status.json
{"state": "installing", "progress": 80, "description": "Starting new containers"}
EOF
docker-compose --file $UMBREL_DIR/docker-compose.yml up --detach --remove-orphans