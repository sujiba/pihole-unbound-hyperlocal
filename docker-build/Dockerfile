# Get the latest Pi-hole version
FROM pihole/pihole:2022.04.1

# Install necessary programs
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    unbound \
    wget

# Additional configs
# unbound
# COPY unbound-v1.9_pihole.conf  /etc/unbound/unbound.conf.d/pihole.conf
COPY unbound-v1.13.1_pihole.conf  /etc/unbound/unbound.conf.d/pihole.conf

# Download the DNS-Root-Zone. 
# Create the chroot directory and generate root.key.
# Copy / move files and change owner.
RUN wget -O root.hints https://www.internic.net/domain/named.root && \
    mv root.hints /var/lib/unbound/ && \
    chown -R unbound:unbound /var/lib/unbound/root.hints

# Unbound startup script
COPY start_unbound_and_s6_init.sh start_unbound_and_s6_init.sh
RUN chmod +x start_unbound_and_s6_init.sh
ENTRYPOINT ./start_unbound_and_s6_init.sh

# Remove unnecessary programs
RUN apt-get remove -y \
    wget
