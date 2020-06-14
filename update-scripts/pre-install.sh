#!/bin/bash -e

echo "This script runs before the update is installed"

# Cleanup just in case there's temp stuff lying around from previous update
# [ -d /tmp/new-dir-tree ] && rm -rf /tmp/new-dir-tree
# [ -d /tmp/prev-dir-tree ] && rm -rf /tmp/prev-dir-tree

# Backup existing dir tree
# rsync -av /home/umbrel/ --exclude='.*' --exclude='bitcoin' --exclude='lnd' --exclude='db' --exclude='secrets' /tmp/prev-dir-tree/