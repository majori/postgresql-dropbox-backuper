#!/usr/bin/env bash
echo "${INTERVAL:-"0 0 * * *"} /root/run-backup.sh > /dev/stdout" >> /etc/crontabs/root
crond -l 2 -f