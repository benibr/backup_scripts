# backup scripts


## backup_home.sh
meant to write data via SMB to a remote host with restic

```/home/$USER/.config/backup/environment:
MOUNT_SMB=blackmesaeast.local/backup
PING_TEST=blackmesaeast.local #optional
FILESYSTEMS="/ /home"
```

```/home/${USER}/.config/backup/excludes
tmp/
/var/lib/docker
```


## backup_s3.sh
meant so safe data on s3 bucket

First create a backup eg. `backup` with user and password.
if you set `WRITE_ONLY` it won't attempt to delete data.

```/home/$USER/.config/backup/environment:
PING_TEST=de.remote.foo #optional
FILESYSTEMS="/ /home"

RESTIC_REPOSITORY="s3:https://s3.example/restic-demo"
AWS_ACCESS_KEY_ID="LAIUDSAJSGDV"
AWS_SECRET_ACCESS_KEY="DSAFUZAANCXNBIAFEUIASUFAK"
RESTIC_PASSWORD="foobar"
WRITE_ONLY=True #optional
```

```/home/${USER}/.config/backup/excludes
tmp/
/var/lib/docker
```
