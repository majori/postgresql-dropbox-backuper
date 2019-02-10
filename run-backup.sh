#!/usr/bin/env bash
FILE_NAME=${PGHOSTNAME}_dump_`date "+%Y-%m-%dT%H-%M-%S"`.sql.gz

pg_dump ${PGDATABASE:-postgres} -c -h $PGHOSTNAME -U ${PGUSERNAME:-postgres} | gzip > /root/dumps/$FILE_NAME
/root/dropbox_uploader.sh upload /root/dumps/$FILE_NAME $FILE_NAME