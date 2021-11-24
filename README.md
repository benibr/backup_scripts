# backup scripts
meant to write data via SMB to a remote host with restic

```/home/$USER/.config/backup/environment:
MOUNT_SMB=blackmesaeast.local/backup
PING_TEST=blackmesaeast.local
FILESYSTEMS="/ /home"
```

```/home/${USER}/.config/backup/excludes
tmp/
/var/lib/docker
```
