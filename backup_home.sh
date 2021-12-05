#!/bin/bash

USER="$(id -un)"
REMOTE_USER=$USER

source /home/$USER/.config/backup/environment 2>/dev/null \
  || source /root/.config/backup/environment 2>/dev/null \
  || ( echo "Error no config environment found" && exit 1 )

if [[ -n "${PING_TEST}" ]]; then
  ping ${PING_TEST} -w1 -t1 &>/dev/null 
  if [ $? -ne 0 ]; then 
    echo "cannot reach ${PING_TEST}" && exit 1
  fi
fi

echo "sudo required. Enter password if nessesary"
sudo true && echo "sudo accuired" || exit 1

if [[ -n "${MOUNT_SMB}" ]]; then
  trap 'sudo umount /mnt; exit 2' KILL TERM INT
  sudo mount.cifs ${MOUNT_SMB} /mnt/ -o user="${REMOTE_USER}" || exit 1
  declare -x RESTIC_REPOSITORY="/mnt/${REMOTE_USER}/$(hostname)/restic/"
fi

if [[ -z "${RESTIC_PASSWORD}" ]]; then
  echo -n "restic password:"
  read -s pw
  declare -x RESTIC_PASSWORD="$pw"
fi

sudo -E restic backup ${FILESYSTEMS?} -x --cleanup-cache --exclude-file /home/${USER}/.config/backup/excludes
sudo -E restic snapshots
sudo -E restic forget --keep-daily=7 --keep-weekly=4 --keep-monthly=6 --keep-yearly 2 --prune

sudo umount /mnt
