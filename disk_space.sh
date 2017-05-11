#!/bin/sh

scripts=$(dirname "$0")
drives=$(df -l -k | awk '{print $6}' | grep -v docker | grep -v boot | grep -v run | grep -v sys | grep -v shm | grep -v /dev | grep -v Mounted)

for drive in $drives;
do
  entry=$(df -k $drive | grep $drive)
  entry=$(echo $entry | sed 's/\/dev\///') # remove /dev/ prefix

  name=$(echo $entry | awk '{print $1}')
  used=$(echo $entry | awk '{print $3}')
  available=$(echo $entry | awk '{print $4}')

  $scripts/_report.sh disk.$name.space.used $used
  $scripts/_report.sh disk.$name.space.available $available
done
