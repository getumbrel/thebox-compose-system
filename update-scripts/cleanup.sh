#!/bin/bash -e

echo "==== OTA UPDATE ===== | STAGE: CLEANUP"

# Delete previous (unused) images
echo "Deleting previous unused images"
docker image prune --all --force

# Cleanup
echo "Deleting temporary directories"
[ -d /tmp/new-dir-tree ] && rm -rf /tmp/new-dir-tree
[ -d /tmp/prev-dir-tree ] && rm -rf /tmp/prev-dir-tree