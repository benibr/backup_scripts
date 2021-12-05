# backup scripts


## backup_home.sh
meant to write data via SMB to a remote host with restic

```/home/$USER/.config/backup/environment:
MOUNT_SMB=foo.local/backup
PING_TEST=foo.local #optional
FILESYSTEMS="/ /home"
```

```/home/${USER}/.config/backup/excludes
tmp/
/var/lib/docker
```


## backup_s3.sh
meant so safe data on s3 bucket

First create a backup eg. `backup` with user and password.

```/home/$USER/.config/backup/environment:
PING_TEST=de.remote.foo #optional
FILESYSTEMS="/ /home"

RESTIC_REPOSITORY="s3:https://s3.example/restic-demo"
AWS_ACCESS_KEY_ID="LAIUDSAJSGDV"
AWS_SECRET_ACCESS_KEY="DSAFUZAANCXNBIAFEUIASUFAK"
RESTIC_PASSWORD="foobar"
```

```/home/${USER}/.config/backup/excludes
tmp/
/var/lib/docker
```
