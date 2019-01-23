FROM alpine
WORKDIR /root

RUN apk update
RUN apk add --no-cache postgresql curl gzip bash tzdata

RUN curl "https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o dropbox_uploader.sh
RUN chmod +x dropbox_uploader.sh

COPY run-backup.sh .
RUN chmod +x ./run-backup.sh

RUN touch .dropbox_uploader
RUN echo 'OAUTH_ACCESS_TOKEN=$DROPBOX_TOKEN' > ./.dropbox_uploader

RUN cp /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
RUN echo "Europe/Helsinki" > /etc/timezone

RUN mkdir dumps

# TODO: Get interval from variable
RUN echo '0 8 * * * /root/run-backup.sh' >> /etc/crontabs/root

CMD ["crond", "-f"]