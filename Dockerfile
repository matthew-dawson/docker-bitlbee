FROM buildpack-deps:stable-scm
LABEL maintainer="Matthew Dawson <github@matthewdawson.dev>"
LABEL name="BitlBee Docker container original work by Michele Bologna"
LABEL version="3.6-1-20210130"

ENV BITLBEE_VERSION=3.6-1

COPY build.sh /root
RUN /root/build.sh

VOLUME ["/usr/local/etc/bitlbee"]
VOLUME ["/var/lib/bitlbee"]
EXPOSE 6667
CMD ["/usr/local/sbin/bitlbee", "-c", "/usr/local/etc/bitlbee/bitlbee.conf", "-n", "-v"]
USER bitlbee
