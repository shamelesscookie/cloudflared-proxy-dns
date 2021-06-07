FROM --platform=amd64 ubuntu:21.04

ENV \
  CLOUDFLARED_URL=https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
  CLOUDFLARED_FILENAME=cloudflared-stable-linux-amd64.deb \
  CLOUDFLARED_SHA256=e14bd7e90ed41366491c68f1849b207388214241fd80b3a88e2694a8a1d085ac \
  DEBIAN_FRONTEND=noninteractive \
  TUNNEL_DNS_ADDRESS=127.0.0.1 \
  TUNNEL_DNS_PORT=53 \
  TUNNEL_DNS_UPSTREAM=https://1.1.1.1/dns-query

RUN \
  apt update && apt upgrade -y && apt install -y curl && \
  curl ${CLOUDFLARED_URL} -o ${CLOUDFLARED_FILENAME} && \
  sha256sum ${CLOUDFLARED_FILENAME} | grep ${CLOUDFLARED_SHA256} && \
  dpkg -i ${CLOUDFLARED_FILENAME} && \
  apt remove -y curl && \
  apt autoremove -y && \
  rm -rf /var/cache/apk/*

EXPOSE 53/udp

ENTRYPOINT [ "cloudflared" ]

CMD [ "proxy-dns" ]
