#!/bin/bash -e

UMBREL_DIR=$(dirname $(readlink -f $0))
RELEASE="v$(cat $UMBREL_DIR/update/START)"
UMBREL_USER=$(logname)

echo "==== OTA UPDATE ===== | STAGE: DOWNLOAD"

cat <<EOF > $UMBREL_DIR/update/status.json
{"state": "installing", "progress": 10, "description": "Downloading Umbrel $RELEASE"}
EOF

# Cleanup just in case there's temp stuff lying around from previous update
echo "Cleaning up any previous mess"
[ -d /tmp/umbrel-$RELEASE ] && rm -rf /tmp/umbrel-$RELEASE

# Clone new dir tree
echo "Downloading Umbrel $RELEASE"
git clone -b $RELEASE https://github.com/mayankchhabra/umbrel-compose.git /tmp/umbrel-$RELEASE

cd /tmp/umbrel-$RELEASE/update

echo "Running update install scripts"
for i in {00..99}; do
    if [ -x ${i}-run.sh ]; then
        echo "Begin ${i}-run.sh"
        ./${i}-run.sh $RELEASE $UMBREL_DIR $UMBREL_USER
        echo "End ${i}-run.sh"
    fi
done

echo "Deleting cloned repository"
[ -d /tmp/umbrel-$RELEASE ] && rm -rf /tmp/umbrel-$RELEASE