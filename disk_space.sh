#!/bin/sh

drives=$(df -l -k | grep dev | awk '{print $9}')

for drive in $drives;
do
  entry=$(df -k $drive | grep $drive)
  entry=$(echo $entry | sed 's/\/dev\///') # remove /dev/ prefix

  name=$(echo $entry | awk '{print $1}')
  used=$(echo $entry | awk '{print $3}')
  available=$(echo $entry | awk '{print $4}')
  . _report.sh $name.space.used $used
  . _report.sh $name.space.available $available
done
