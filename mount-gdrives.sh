#!/bin/bash

BaseDir=$HOME/GDrive
[ ! -d "$BaseDir" ] && mkdir $BaseDir;

while true; do
  # check to see if there is a connection by pinging a Google server
  if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
    # if connected, mount the drive and break the loop
    while read Drive; do
      IFS=, read DriveLabel DriveId <<< $Drive;
      echo $DriveLabel
      MountDir=$BaseDir/$DriveLabel
      [ ! -d "$MountDir" ] && mkdir $MountDir;
      google-drive-ocamlfuse -label $DriveLabel $MountDir;
    done <$HOME/.gdfuse/drives.csv
    break;
  else
    # if not connected, wait for one second and then check again
    sleep 1
  fi
done
