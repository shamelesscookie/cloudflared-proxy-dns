## cloudflared-proxy-dns

Dockerfile for cloudflared, intended for use as a secure DNS-over-HTTPS proxy.

https://developers.cloudflare.com/argo-tunnel/reference/doh/
https://developers.cloudflare.com/1.1.1.1/dns-over-https/cloudflared-proxy/

### standalone example

```bash
$ docker run --rm -it \
  -e TUNNEL_DNS_ADDRESS=0.0.0.0 \
  -e TUNNEL_DNS_PORT=53 \
  -p 53:53/udp \
  shamelesscookie/cloudflared-proxy-dns
```

### docker-compose example

```bash
version: '2.1'
services:
  dns-proxy:
    container_name: dns-proxy
    image: shamelesscookie/cloudflared-proxy-dns
    ports:
      - 53:53/udp
    restart: always
    environment:
      - TUNNEL_DNS_ADDRESS=0.0.0.0  
      - TUNNEL_DNS_PORT=53
```
