FROM alpine:3.13.1

MAINTAINER Amit <amitmmc1@gmail.com>

# Use docker build --pull -t amitmmc1/freeradius:7Apr2022 .


RUN apk --update add freeradius freeradius-mysql freeradius-eap openssl

EXPOSE 1812/udp 1813/udp

#ENV DB_HOST=localhost
#ENV DB_PORT=3306
#ENV DB_USER=radius
#ENV DB_PASS=radpass
#ENV DB_NAME=radius
#ENV RADIUS_KEY=testing123
#ENV RAD_CLIENTS=10.0.0.0/24
#ENV RAD_DEBUG=no

ADD --chown=root:radius ./etc/raddb/ /etc/raddb
RUN /etc/raddb/certs/bootstrap && \
#    chown -R root:radius /etc/raddb/certs && \
    chmod 640 /etc/raddb/certs/*.pem


ADD ./scripts/start.sh /start.sh
ADD ./scripts/wait-for.sh /wait-for.sh

RUN chmod +x /start.sh wait-for.sh

CMD ["/start.sh"]
