#!/bin/bash -e

echo "==== OTA UPDATE ===== | STAGE: PRE-UPDATE"

# Cleanup just in case there's temp stuff lying around from previous update
echo "Cleaning up any previous mess"
[ -d /tmp/new-dir-tree ] && rm -rf /tmp/new-dir-tree
[ -d /tmp/prev-dir-tree ] && rm -rf /tmp/prev-dir-tree

# Backup existing dir tree
echo "Backing up /home/umbrel/ directory tree"
rsync -av /home/umbrel/ --exclude='.*' --exclude='bitcoin' --exclude='lnd' --exclude='db' --exclude='secrets' /tmp/prev-dir-tree/