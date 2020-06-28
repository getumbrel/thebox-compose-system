  
#!/bin/bash -e

RELEASE=$1
UMBREL_DIR=$2

echo "==== OTA UPDATE ===== | STAGE: SUCCESS"

# Delete previous (unused) images
echo "Deleting previous images"
cat <<EOF > $UMBREL_DIR/update/status.json
{"state": "installing", "progress": 90, "description": "Deleting previous images"}
EOF
# docker image prune --all --force

# Cleanup
echo "Removing backup"
cat <<EOF > $UMBREL_DIR/update/status.json
{"state": "installing", "progress": 95, "description": "Removing backup"}
EOF
[ -d /tmp/umbrel-backup ] && rm -rf /tmp/umbrel-backup

echo "Successfully installed Umbrel $RELEASE"
cat <<EOF > $UMBREL_DIR/update/status.json
{"state": "installed", "progress": 100, "description": "Successfully installed Umbrel $RELEASE"}
EOF