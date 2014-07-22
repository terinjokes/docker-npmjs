# Version: 0.7.0-head
FROM terinjokes/couchdb
MAINTAINER Terin Stock <terinjokes@gmail.com>

ENV HOME /root

CMD ["/sbin/my_init"]

ADD build /build/docker-npmjs

RUN /build/docker-npmjs/prepare.sh
RUN /build/docker-npmjs/install_node.sh
RUN /build/docker-npmjs/install_npmjs.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
