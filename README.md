# postgresql-dropbox-backuper
[![Build Status](https://travis-ci.com/majori/postgresql-dropbox-backuper.svg?branch=master)](https://travis-ci.com/majori/postgresql-dropbox-backuper) [![Pulls](https://img.shields.io/docker/pulls/majori/postgresql-dropbox-backuper.svg?style=flat-square)](https://cloud.docker.com/repository/docker/majori/postgresql-dropbox-backuper)

Backup PostgreSQL database running inside Docker regularly to your Dropbox account.

**How it works**

The script uses `pg_dump` to create dump from the database, compress it with `gzip` and uses [Dropbox Uploader](https://github.com/andreafabrizi/Dropbox-Uploader) to upload the compressed dump to your Dropbox account. `Cron` will run the script with the specified interval.

## Getting started
* Create new app for your Dropbox account with [App Console](https://www.dropbox.com/developers/apps)
* Generate access token for you app and copy it
* Start the container
  ```
  docker run \
    --name pg-backuper \
    --network container:<postgresql-container-name> \
    -e "DROPBOX_TOKEN=<your-access-token>" \
    -e "PGHOSTNAME=<postgresql-container-name>" \
    -e "PGDATABASE=<...>" \
    -e "PGUSERNAME=<...>" \
    -e "PGPASSWORD=<...>" \
    -e "INTERVAL='0 0 * * *'" \
    -d \
    majori/postgresql-dropbox-backuper
  ```

## Environment variables
**DROPBOX_TOKEN**

**PGHOSTNAME**

**PGPASSWORD**

**PGDATABASE** (default postgres)

**PGUSERNAME** (default postgres)

**INTERVAL** (defaults "0 0 * * *")

**PASSWORD** (optional) Encrypt database dump with OpenSSL