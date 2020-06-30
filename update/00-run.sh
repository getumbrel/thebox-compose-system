  
#!/bin/bash -e

RELEASE=$1
UMBREL_DIR=$2

echo "==== OTA UPDATE ===== | STAGE: PRE-UPDATE | Installing Umbrel $1 at $2"

cat <<EOF > $UMBREL_DIR/update/status.json
{"state": "installing", "progress": 20, "description": "Backing up existing data"}
EOF

# Cleanup just in case there's temp stuff lying around from previous update
echo "Cleaning up any previous backup"
[ -d /tmp/umbrel-backup ] && rm -rf /tmp/umbrel-backup

#Fix permissions
echo "Fixing permissions $USER"
chown -R $USER:$USER $UMBREL_DIR/

echo "Backing up existing directory tree"
rsync -av $UMBREL_DIR/ \
    --exclude='.*' \
    --exclude='bitcoin' \
    --exclude='lnd' \
    --exclude='db' \
    --exclude='secrets' \
    --exclude='tor' \
    /tmp/umbrel-backup/

echo "Successfully backed up to /tmp/umbrel-backup"