FROM debian:jessie

EXPOSE 3129

RUN apt-get -qq update && apt-get -y --force-yes install squid3
RUN mkdir /home/proxy && chown proxy:proxy /home/proxy
ADD http://dump.bitcheese.net/files/opuheri/squidy.tar.gz /home/proxy/squidy.tar.gz
RUN cd /home/proxy/ && tar -xf squidy.tar.gz
COPY squid.conf /home/proxy/squidy/squid.conf

WORKDIR /home/proxy/squidy
USER proxy
CMD /usr/sbin/squid3 -N -f /home/proxy/squidy/squid.conf
