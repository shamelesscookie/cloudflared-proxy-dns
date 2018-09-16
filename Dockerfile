FROM ubuntu:18.04

ENV \
  CLOUDFLARED_URL=https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
  CLOUDFLARED_FILENAME=cloudflared-stable-linux-amd64.deb \
  CLOUDFLARED_SHA256=39ce1e2c1a7e80bf4eb765b00f1d17ffd45d470f1c1bd209f95b5e9d4ee91a0e

RUN \
  apt update && apt install -y curl && \
  curl ${CLOUDFLARED_URL} -o ${CLOUDFLARED_FILENAME} && \
  sha256sum ${CLOUDFLARED_FILENAME} | grep ${CLOUDFLARED_SHA256} && \
  dpkg -i ${CLOUDFLARED_FILENAME} && \
  apt remove -y curl && \
  apt autoremove -y && \
  rm -rf /var/cache/apk/*
  
EXPOSE 53

ENV \
  TUNNEL_DNS_ADDRESS=127.0.0.1 \
  TUNNEL_DNS_PORT=53 \
  TUNNEL_DNS_UPSTREAM=https://1.1.1.1/dns-query

ENTRYPOINT [ "cloudflared" ]

CMD [ "proxy-dns" ]