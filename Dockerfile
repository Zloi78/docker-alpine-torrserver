FROM frolvlad/alpine-glibc:latest

ARG ARG_TZ='Europe/Moscow'

ENV ENV_TZ ${ARG_TZ}

RUN apk add --no-cache tzdata && \
    apk add --no-cache curl && mkdir -p /torrserver/db && \
    version=$(curl -s "https://github.com/YouROK/TorrServer/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#') && \
    curl -o /torrserver/TorrServer -L "https://github.com/YouROK/TorrServer/releases/download/${version}/TorrServer-linux-amd64" && \
    chmod +x /torrserver/TorrServer \
    && ls /usr/share/zoneinfo \
    && cp /usr/share/zoneinfo/${ENV_TZ} /etc/localtime \
    && echo "${ENV_TZ}" > /etc/timezone \
    && apk del tzdata 

EXPOSE 8090
ENTRYPOINT /torrserver/TorrServer --path /torrserver/db
VOLUME /torrserver/db
