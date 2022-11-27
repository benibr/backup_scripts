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

sudo -E rsync -r -x -l --inplace --append --exclude-from /home/${USER}/.config/backup/excludes ${FILESYSTEMS?} ${REMOTE_USER}@${SSH_REMOTE}
