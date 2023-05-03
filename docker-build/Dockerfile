# Get the latest Pi-hole version
FROM pihole/pihole:2023.01.10

# Install necessary programs
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    unbound \
    wget

# Additional configs
# unbound
COPY unbound-pihole.conf  /etc/unbound/unbound.conf.d/pihole.conf

# Set edns packet limit for dnsmasq
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf

# Download DNS-Root-Zone. 
# Create the chroot directory and generate root.key.
# Copy / move files and change owner.
RUN wget -O root.hints https://www.internic.net/domain/named.root && \
    mv root.hints /var/lib/unbound/ && \
    chown -R unbound:unbound /var/lib/unbound/root.hints

# Remove unnecessary programs
RUN apt-get remove -y \
    wget

# Unbound startup script
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run
RUN chmod ug+x /etc/services.d/unbound/run 

ENTRYPOINT ./s6-init
