#!/bin/sh

scripts=$(dirname "$0")
value=$(cat /proc/uptime | awk '{ print $1; }')
$scripts/_report.sh system.uptime $value
