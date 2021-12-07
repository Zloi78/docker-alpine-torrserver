FROM frolvlad/alpine-glibc:latest

RUN apk add --no-cache curl && mkdir -p /torrserver/db && \
    version=$(curl -s "https://github.com/YouROK/TorrServer/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#') && \
    curl -o /torrserver/TorrServer -L "https://github.com/YouROK/TorrServer/releases/download/${version}/TorrServer-linux-amd64" && \
    chmod +x /torrserver/TorrServer
    
EXPOSE 8090
ENTRYPOINT /torrserver/TorrServer --path /torrserver/db
VOLUME /torrserver/db
