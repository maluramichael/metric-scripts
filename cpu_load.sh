#!/bin/sh

scripts=$(dirname "$0")
value=$(awk '{print $1}' < /proc/loadavg)
$scripts/_report.sh system.load $value
