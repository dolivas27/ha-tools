#!/bin/bash
# Mount TrueNAS Shared_Data
MOUNT_POINT="/mnt/truenas"
SHARE="//10.10.1.220/Shared_Data"

# Create mount point if it doesn't exist
if [ ! -d "$MOUNT_POINT" ]; then
    sudo mkdir -p "$MOUNT_POINT"
fi

# Prompt for credentials
read -p "TrueNAS username: " TRUENAS_USER
read -s -p "TrueNAS password: " TRUENAS_PASS
echo

# Mount the share
sudo mount -t cifs "$SHARE" "$MOUNT_POINT" \
  -o username="$TRUENAS_USER",password="$TRUENAS_PASS",vers=3.0,uid=$(id -u),gid=$(id -g)

if [ $? -eq 0 ]; then
    echo "Mounted successfully at $MOUNT_POINT"
else
    echo "Mount failed — check credentials or share availability"
fi
