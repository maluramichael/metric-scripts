#!/bin/sh

. ~/.metrics

SERVER=$GRAPHITE_SERVER
PORT=$GRAPHITE_PORT

echo "SEND $(hostname).$1 $2 `date +%s`"
echo "$(hostname).$1 $2 `date +%s`" | nc -q0 ${SERVER} ${PORT}
