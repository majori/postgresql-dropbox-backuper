#!/usr/bin/env bash
FILE_NAME=${CONTAINER_NAME}_dump_`date "+%Y-%m-%dT%H-%M-%S"`.sql.gz

pg_dump ${PGDATABASE:-postgres} -c -h $CONTAINER_NAME -U ${PGUSERNAME:-postgres} | gzip > /root/dumps/$FILE_NAME
/root/dropbox_uploader.sh upload /root/dumps/$FILE_NAME $FILE_NAME