#!/usr/bin/env bash

echo -n "Launch args: "
echo "$@"

cd /app/run || exit 1
if [ "$1" == "update" ]; then
    exec su user -c './../build/result/bin/update'
elif [ "$1" == "init" ]; then
    exec su user -c './../build/result/bin/init'
elif [ "$1" == "cron" ]; then
    exec crond -f
else
    exec su user -c "$@"
fi
