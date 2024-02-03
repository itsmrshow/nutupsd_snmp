FROM ubuntu:20.04
MAINTAINER Rob Seccareccia

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.license=GPL-2.0 \
    org.label-schema.name=nut-upsd 

ENV API_USER=upsmon \
    API_PASSWORD= \
    DESCRIPTION=UPS \
    DRIVER=snmp-ups \
    GROUP=nut \
    NAME=ups \
    POLLINTERVAL= \
    PORT=auto \
    SDORDER= \
    SECRET=nut-upsd-password \
    SERIAL= \
    SERVER=master \
    USER=nut \
    VENDORID=

RUN apt-get update

RUN apt-get install -y --no-install-recommends dialog apt-utils 

RUN apt-get install -y --no-install-recommends \
    nut nut-server nut-snmp && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3493

COPY ups.conf /etc/nut/
COPY nut.conf /etc/nut/
COPY upsd.conf /etc/nut/
COPY upsd.users /etc/nut/
COPY start_nut.sh start_nut.sh

RUN ["chmod", "+x", "./start_nut.sh"]
#CMD ["screen", "-d", "-m", "/usr/lib/nut/snmp-ups", "-a", "apcups", "-DD"]
#CMD ["/usr/sbin/upsd", "-DD"]
CMD ./start_nut.sh
