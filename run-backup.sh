#!/usr/bin/env bash
set -e

PG_DATABASE=${PG_DATABASE:-postgres}
PG_USERNAME=${PG_USERNAME:-postgres}

WORKING_DIR=/root/dumps
FILE_NAME=${PG_HOSTNAME}_${PG_DATABASE}_dump_`date "+%Y-%m-%dT%H-%M-%S"`.sql.gz

export PGPASSWORD=$PG_PASSWORD # pg_dump reads password from variable PGPASSWORD

pg_dump ${PG_DATABASE} -w -c -h $PG_HOSTNAME -U ${PG_USERNAME} | gzip > $WORKING_DIR/$FILE_NAME
if [ -n $PASSWORD ]; then
  openssl enc -aes-256-cbc -pass env:PASSWORD -in $WORKING_DIR/$FILE_NAME -out $WORKING_DIR/$FILE_NAME.enc
  rm $WORKING_DIR/$FILE_NAME
  FILE_NAME=$FILE_NAME.enc
fi

if [ $? -eq 0 ]; then
  /root/dropbox_uploader.sh upload $WORKING_DIR/$FILE_NAME $FILE_NAME
  rm $WORKING_DIR/$FILE_NAME
fi