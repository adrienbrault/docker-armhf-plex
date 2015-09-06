FROM resin/rpi-raspbian:jessie-2015-09-02

MAINTAINER Adrien Brault <adrien.brault@gmail.com>

RUN apt-get update -q && \
    apt-get install wget apt-transport-https supervisor -qy --force-yes && \
    wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key | apt-key add - && \
    echo "deb https://dev2day.de/pms/ jessie main" | tee /etc/apt/sources.list.d/pms.list && \
    apt-get update -q && \
    apt-get install plexmediaserver -qy && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/config","/media"]

ENV HOME=/config

# Force plex to try transcoding
RUN find /usr/lib/plexmediaserver -name plex.js -exec sed -i -e "s/validateTranscoder:function(t,n){var/validateTranscoder:function(t,n){return false;var/g" {} \;

EXPOSE 32400
EXPOSE 3000

CMD ["/usr/sbin/start_pms"]
