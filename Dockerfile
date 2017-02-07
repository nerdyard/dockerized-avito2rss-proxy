FROM debian:jessie

EXPOSE 3129
WORKDIR /root/squidy

RUN apt-get -qq update && apt-get -y --force-yes install squid3
RUN mkdir /home/proxy && chown proxy:proxy /home/proxy
ADD http://dump.bitcheese.net/files/opuheri/squidy.tar.gz /home/proxy/squidy.tar.gz
RUN cd /home/proxy/ && tar -xf squidy.tar.gz
RUN sed -i 's|ncsa_auth|basic_ncsa_auth|' /home/proxy/squidy/squid.conf

USER proxy
CMD /usr/sbin/squid3 -N -f /home/proxy/squidy/squid.conf
