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

create a bucket and create a config

```/home/$USER/.config/backup/environment:
PING_TEST=de.remote.foo #optional
FILESYSTEMS="/ /home"

RESTIC_REPOSITORY="b2:bucket"
B2_ACCOUNT_ID="LAIUDSAJSGDV"
B2_ACCOUNT_KEY="DSAFUZAANCXNBIAFEUIASUFAK"
RESTIC_PASSWORD="foobar"
```

source the file and init the repo, afterwards just run the script

```/home/${USER}/.config/backup/excludes
tmp/
/var/lib/docker
```
