FROM ubuntu:18.04

ENV \
  CLOUDFLARED_URL=https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
  CLOUDFLARED_FILENAME=cloudflared-stable-linux-amd64.deb \
  CLOUDFLARED_SHA256=dfd1a472bf610ae086833de3d77fbdbec5d06a14d78835d8c55d7198e15340d5 \
  DEBIAN_FRONTEND=noninteractive \
  TUNNEL_DNS_ADDRESS=127.0.0.1 \
  TUNNEL_DNS_PORT=53 \
  TUNNEL_DNS_UPSTREAM=https://1.1.1.1/dns-query

RUN \
  apt update && apt install -y curl && \
  curl ${CLOUDFLARED_URL} -o ${CLOUDFLARED_FILENAME} && \
  sha256sum ${CLOUDFLARED_FILENAME} | grep ${CLOUDFLARED_SHA256} && \
  dpkg -i ${CLOUDFLARED_FILENAME} && \
  apt remove -y curl && \
  apt autoremove -y && \
  rm -rf /var/cache/apk/*

EXPOSE 53/udp

ENTRYPOINT [ "cloudflared" ]

CMD [ "proxy-dns" ]
