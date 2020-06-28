  
#!/bin/bash -e

RELEASE=$1
UMBREL_DIR=$2

echo "==== OTA UPDATE ===== | STAGE: SUCCESS"

# Delete previous (unused) images
echo "Deleting previous images"
# docker image prune --all --force

# Cleanup
echo "Deleting backup"
[ -d /tmp/umbrel-backup ] && rm -rf /tmp/umbrel-backup