# Install

Follow the instruction for installing [google-drive-ocamlfuse](https://github.com/astrada/google-drive-ocamlfuse):

```
sudo add-apt-repository ppa:alessandro-strada/ppa
sudo apt-get update
sudo apt-get install google-drive-ocamlfuse
```

# Mount at startup

You can edit `/etc/fstab` and add a line

```
DriveLabel   /home/user/GDrive/DriveLabel   fuse.gdfuse    noauto,uid=1000,gid=1000,allow_other,user,_netdev     0       0
```

to mount a Google drive at startup. But this only works if your internet connection is ready _before_ `systemd` mounts the targets in `/etc/fstab`. Your wifi connection will not yet be available causing the automount to fail. The `mount-gdrives.sh` script waits until the internet connection becomes available and then mounts the Google drives using the `google-drive-ocamlfuse` command.

# Mount multiple shared drives

You can mount multiple Google shared drives in three steps:

1. Run `google-drive-ocamlfuse` to initialize the setup.
2. Edit the `drives.csv` file to add drive labels and drive ids.
3. Run `setup-gdrives.sh`.

The script creates folders in `~/.gdfuse` for every drive and adds a copy of the default config with the respective `team_drive_id`. The script copies `drives.csv` and `mount-gdrives.sh` to `~/.gdfuse` and adds `mount-gdrives.desktop` to `~/.config/autostart/` to mount the Google drives on startup.

# Unmount

To unmount the filesystem, issue this command:

```
fusermount -u mountpoint
```