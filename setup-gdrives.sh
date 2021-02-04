#!/bin/bash

while read Drive; do
  IFS=, read DriveLabel DriveId <<< $Drive;
  echo $DriveLabel
  DriveDir=$HOME/.gdfuse/$DriveLabel
  [ ! -d "$DriveDir" ] && mkdir $DriveDir;
  sed "s/team_drive_id=/team_drive_id=$DriveId/g" $HOME/.gdfuse/default/config > $DriveDir/config;
done <drives.csv

cp -t $HOME/.gdfuse ./drives.csv ./mount-gdrives.sh
sed "s#Exec=~#Exec=$HOME#g" ./mount-gdrives.desktop > $HOME/.config/autostart/mount-gdrives.desktop;