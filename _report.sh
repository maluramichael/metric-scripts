#!/bin/sh

SERVER=$GAPHITE_SERVER
PORT=$GAPHITE_PORT

echo "$(hostname).$1 $2 `date +%s`" # | nc -c ${SERVER} ${PORT}