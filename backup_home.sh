#!/bin/bash

USER="$(id -un)"

source /home/$USER/.config/backup/environment

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
  sudo mount.cifs ${MOUNT_SMB} /mnt/ -o user="${USER}" || exit 1
  [[ -z "${RESTIC_PASSWORD}" ]] && \
    echo -n "restic password:" && \
    read -s pw && \
    declare -x RESTIC_PASSWORD="$pw"
    declare -x RESTIC_REPOSITORY="/mnt/${USER}/$(hostname)/restic/"
fi

sudo -E restic backup ${FILESYSTEMS?} -x --cleanup-cache --exclude-file /home/${USER}/.config/backup/excludes
sudo -E restic snapshots

sudo umount /mnt
