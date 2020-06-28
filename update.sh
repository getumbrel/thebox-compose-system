#!/bin/bash -e

RELEASE="ota-update"
UMBREL_DIR=$(dirname $(readlink -f $0))

echo "==== OTA UPDATE ===== | STAGE: DOWNLOAD"

# Cleanup just in case there's temp stuff lying around from previous update
echo "Cleaning up any previous mess"
[ -d /tmp/umbrel-$RELEASE ] && rm -rf /tmp/umbrel-$RELEASE

# Clone new dir tree
echo "Cloning repository"
git clone -b $RELEASE https://github.com/mayankchhabra/umbrel-compose.git /tmp/umbrel-$RELEASE

cd /tmp/umbrel-$RELEASE/update

echo "Running update install scripts"
for i in {00..99}; do
    if [ -x ${i}-run.sh ]; then
        echo "Begin ${i}-run.sh"
        ./${i}-run.sh $RELEASE $UMBREL_DIR
        echo "End ${i}-run.sh"
    fi
done

echo "Deleting cloned repository"
# [ -d /tmp/umbrel-$RELEASE ] && rm -rf /tmp/umbrel-$RELEASE