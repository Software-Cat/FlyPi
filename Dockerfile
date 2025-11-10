FROM adguard/adguardhome:latest

#ENV INTERFACE eth0
#ENV DNSMASQ_LISTENING ALL

RUN apk update && apk add ca-certificates iptables ip6tables && rm -rf /var/cache/apk/*

WORKDIR /app
COPY ./start.sh ./start.sh

# Copy Tailscale binaries from the tailscale image on Docker Hub.
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscaled /app/tailscaled
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscale /app/tailscale
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale


# Run on container startup. This appears broken, must manually ssh into vm and run start.sh
#USER root
#CMD ["/app/start.sh"]
