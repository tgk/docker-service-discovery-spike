# Image for running haproxy and confd, listening for consul updates
FROM ubuntu

RUN apt-get install -y haproxy wget

RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 -O /usr/bin/confd
RUN chmod u+x /usr/bin/confd

COPY confd.toml /etc/confd/conf.d/
COPY haproxy.cfg.tmpl /etc/confd/templates/
COPY start_confd.sh /

CMD ./start_confd.sh
