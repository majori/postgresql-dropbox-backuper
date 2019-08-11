FROM alpine:edge
WORKDIR /root

RUN apk add --no-cache postgresql-client curl gzip bash tzdata openssl

RUN curl "https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o dropbox_uploader.sh
RUN chmod +x dropbox_uploader.sh

COPY run-backup.sh .
RUN chmod +x ./run-backup.sh

RUN touch .dropbox_uploader
RUN echo 'OAUTH_ACCESS_TOKEN=$DROPBOX_TOKEN' > ./.dropbox_uploader

RUN cp /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
RUN echo "Europe/Helsinki" > /etc/timezone

RUN mkdir dumps

COPY init.sh .
RUN chmod +x ./init.sh

CMD ["./init.sh"]