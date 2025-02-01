#!/usr/bin/env bash

echo -n "Launch args: "
echo "$@"

if [ "$1" == "update" ]; then
    cd /app/run || exit 1
    exec su user -c './../build/result/bin/update'
elif [ "$1" == "cron" ]; then
    exec crond -f
else
    exec su user -c "$@"
fi
