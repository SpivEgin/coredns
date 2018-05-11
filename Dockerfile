FROM debian:stretch-slim

# Only need ca-certificates & openssl if want to use DNS over TLS (RFC 7858).

RUN apt-get -y update &&\
    apt-get -y install bind9utils ca-certificates openssl &&\
    apt-get -y upgrade &&\
    apt-get -y clean &&\
    mkdir /opt/dns/ &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD coredns /opt/dns/coredns
ADD coredb /opt/dns/coredb
ADD certs /opt/dns/certs
ADD Corefile /opt/dns/Corefile
ADD TLM.crt /etc/ssl/certs/
ADD cockroach.yml /opt/dns
RUN update-ca-certificates &&\
    chmod + /opt/dns/coredns /opt/dns/coredb &&\
    ln -s /opt/dns/coredns /bin/coredns &&\
    ln -s /opt/dns/coredb /bin/coredb &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/dns

EXPOSE 53 53/udp
#ENTRYPOINT ["/opt/dns/coredns"]
CMD ["/opt/dns/coredns"]