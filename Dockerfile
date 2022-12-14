FROM  python:3.8-alpine
LABEL maintainer="Cyber74 Infra Team [https://github.com/c74infrateam/duologsync-docker]"

ARG   BUILD_DATE
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Duo Log Sync for Cyber74 USM" \
      org.label-schema.description="Python utility for fetching logs from Duo to feed USM Anywhere (Alienvault)" \
      org.label-schema.version="1.0.0"

RUN mkdir /c74app

WORKDIR /c74app

RUN apk update && apk upgrade \
    && apk add git \
    && git clone https://github.com/duosecurity/duo_log_sync.git

WORKDIR /c74app/duo_log_sync

RUN python setup.py install

CMD ["duologsync","/config.yml"]
