#!/bin/bash
# Mount TrueNAS Shared_Data and UnRAID Backups

TRUENAS_MOUNT="/mnt/truenas"
UNRAID_MOUNT="/mnt/unraid"
TRUENAS_SHARE="//10.10.1.220/Shared_Data"
UNRAID_SHARE="//10.10.1.252/Backups"

# Create mount points if they don't exist
if [ ! -d "$TRUENAS_MOUNT" ]; then
    sudo mkdir -p "$TRUENAS_MOUNT"
fi
if [ ! -d "$UNRAID_MOUNT" ]; then
    sudo mkdir -p "$UNRAID_MOUNT"
fi

# TrueNAS credentials
echo "=== TrueNAS ==="
read -p "TrueNAS username: " TRUENAS_USER
read -s -p "TrueNAS password: " TRUENAS_PASS
echo

# Mount TrueNAS
sudo mount -t cifs "$TRUENAS_SHARE" "$TRUENAS_MOUNT" \
  -o username="$TRUENAS_USER",password="$TRUENAS_PASS",vers=3.0,uid=$(id -u),gid=$(id -g)

if [ $? -eq 0 ]; then
    echo "TrueNAS mounted successfully at $TRUENAS_MOUNT"
else
    echo "TrueNAS mount failed — check credentials or share availability"
fi

# UnRAID credentials
echo ""
echo "=== UnRAID ==="
read -p "UnRAID username: " UNRAID_USER
read -s -p "UnRAID password: " UNRAID_PASS
echo

# Mount UnRAID
sudo mount -t cifs "$UNRAID_SHARE" "$UNRAID_MOUNT" \
  -o username="$UNRAID_USER",password="$UNRAID_PASS",vers=3.0,uid=$(id -u),gid=$(id -g)

if [ $? -eq 0 ]; then
    echo "UnRAID mounted successfully at $UNRAID_MOUNT"
else
    echo "UnRAID mount failed — check credentials or share availability"
fi
