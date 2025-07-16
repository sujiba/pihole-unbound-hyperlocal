# Get the latest Pi-hole version
FROM pihole/pihole:2025.07.1

# Install necessary programs without repository caching
RUN apk upgrade --no-cache && \
    apk add --no-cache \
    unbound \ 
    wget

# Additional configs
# unbound
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pihole.conf

# Set edns packet limit for dnsmasq
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf

# Download DNS-Root-Zone and move file
RUN wget -S https://www.internic.net/domain/named.root -O /etc/unbound/root.hints

# Create unbound log dir
RUN install -o unbound -g unbound -Dm755 -d /var/log/unbound

# Add unbound start up script
COPY --chmod=0755 unbound-entrypoint.sh /usr/bin/unbound-entrypoint.sh

ENTRYPOINT ["unbound-entrypoint.sh"]
