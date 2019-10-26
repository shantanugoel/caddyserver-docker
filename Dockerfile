FROM alpine:3.10.3

LABEL maintainer="Shantanu Goel" \
    architecture="arm64v8/aarch64" \
    caddy-version="1.0.3" \
    build="23-Oct-2019"

ARG plugins=docker,tls.dns.cloudflare

RUN apk add --no-cache openssh-client git tar curl libcap tzdata

RUN curl --silent --show-error --fail --location --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/arm64?plugins=${plugins}&license=personal&telemetry=off" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy && \
    chmod 0755 /usr/bin/caddy && \
    addgroup -S -g 1000 caddy && \
    adduser -D -S -s /sbin/nologin -G caddy -u 1000 caddy && \
    setcap cap_net_bind_service=+ep `readlink -f /usr/bin/caddy` && \
    /usr/bin/caddy -version

EXPOSE 80 443 2015
VOLUME /srv
WORKDIR /srv

ENV CADDY_ENV_TLS_EMAIL="test@test.com"
RUN chown -R caddy:caddy /srv

#USER caddy

ADD files/Caddyfile /etc/Caddyfile
ADD files/index.html /srv/index.html

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["-log", "stdout", "-agree"]
