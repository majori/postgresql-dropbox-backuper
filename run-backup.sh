#!/usr/bin/env bash
FILE_NAME=${PGHOSTNAME}_dump_`date "+%Y-%m-%dT%H-%M-%S"`.sql.gz
FILE_PATH=/root/dumps/$FILE_NAME

pg_dump ${PGDATABASE:-postgres} -c -h $PGHOSTNAME -U ${PGUSERNAME:-postgres} | gzip > $FILE_PATH
if [ $? -eq 0 ]; then
  /root/dropbox_uploader.sh upload $FILE_PATH $FILE_NAME
  rm $FILE_PATH
fi