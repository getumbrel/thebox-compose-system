  
#!/bin/bash -e

RELEASE=$1
UMBREL_DIR=$2

echo "==== OTA UPDATE ===== | STAGE: PRE-UPDATE $1 // $2"

# Cleanup just in case there's temp stuff lying around from previous update
echo "Cleaning up any previous backup"
[ -d /tmp/umbrel-backup ] && rm -rf /tmp/umbrel-backup

# Backup existing dir tree
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