#!/bin/bash

ping blackmesaeast.local -w1 -t1 &>/dev/null 
if [ $? -ne 0 ]; then 
  echo "cannot reach blackmesaeast.local" && exit 1
fi

trap 'sudo umount /mnt; exit 2' KILL TERM INT

echo "sudo required. Enter password if nessesary"
sudo true && echo "sudo accuired" || exit 1

sudo mount.cifs //blackmesaeast.local/backup /mnt/ -o user=$(id -un) || exit 1
echo -n "restic password:"
read -s pw
declare -x RESTIC_PASSWORD="$pw"
sudo -E restic backup / -r /mnt/$(id -un)/$(hostname)/restic/ -x --cleanup-cache --exclude "*Media*"
sudo -E restic snapshots -r /mnt/$(id -un)/$(hostname)/restic/
sudo umount /mnt
