#!/bin/bash

USER="$(id -un)"

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

if [[ -z "${RESTIC_PASSWORD}" ]]; then
  echo -n "restic password:"
  read -s pw
  declare -x RESTIC_PASSWORD="$pw"
fi

declare -x RESTIC_PASSWORD
declare -x B2_ACCOUNT_ID
declare -x B2_ACCOUNT_KEY
declare -x RESTIC_REPOSITORY

sudo -E restic backup -r $RESTIC_REPOSITORY ${FILESYSTEMS?} -x --cleanup-cache --exclude-file /home/${USER}/.config/backup/excludes
sudo -E restic snapshots
sudo -E restic forget --keep-daily=7 --keep-weekly=4 --keep-monthly=6 --keep-yearly 2 --prune
