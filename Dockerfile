FROM  python:3.8-alpine
LABEL maintainer="Cyber74 Infra Team [https://github.com/c74infrateam/duologsync-docker]"

ARG   BUILD_DATE
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Duo Log Sync for Cyber74 USM" \
      org.label-schema.description="Python utility for fetching logs from Duo to feed USM Anywhere (Alienvault)" \
      org.label-schema.version="1.0.0"

ENV DUO_SECRET_KEY="CHANGE-ME"
ENV DUO_INTEGRATION_KEY="CHANGE-ME"
ENV DUO_API_HOST="CHANGE-ME"
ENV USM_SENSOR_IP="1.2.3.4"
ENV LOG_FILE_DIR="/tmp"

RUN mkdir /c74app

WORKDIR /c74app

RUN apk update && apk upgrade \
    && apk add git \
    && git clone https://github.com/duosecurity/duo_log_sync.git

WORKDIR /c74app/duo_log_sync

ADD c74template-config.yml /c74app/duo_log_sync/config.yml

RUN sed -i "s/USM-Sensor-IP/${USM_SENSOR_IP}/" config.yml
RUN sed -i "s/Duo-IKEY/${DUO_INTEGRATION_KEY}/" config.yml
RUN sed -i "s/Duo-SKEY/${DUO_SECRET_KEY}/" config.yml
RUN sed -i "s/Duo-APIHOST/${DUO_API_HOST}/" config.yml

RUN python setup.py install

CMD ["duologsync","/c74app/duo_log_sync/config.yml"]
