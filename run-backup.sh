#!/usr/bin/env bash
FILE_NAME=${PGHOSTNAME}_dump_`date "+%Y-%m-%dT%H-%M-%S"`.sql.gz

pg_dump ${PGDATABASE:-postgres} -c -h $PGHOSTNAME -U ${PGUSERNAME:-postgres} | gzip > /root/dumps/$FILE_NAME
if [ -n $PASSWORD ]; then
  openssl enc -aes-256-cbc -pass env:PASSWORD -in /root/dumps/$FILE_NAME -out /root/dumps/$FILE_NAME.enc
  rm /root/dumps/$FILE_NAME
  FILE_NAME=$FILE_NAME.enc
fi

if [ $? -eq 0 ]; then
  /root/dropbox_uploader.sh upload /root/dumps/$FILE_NAME $FILE_NAME
  rm /root/dumps/$FILE_NAME
fi