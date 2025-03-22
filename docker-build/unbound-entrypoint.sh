#!/bin/sh

# Start unbound 
echo "  [i] Starting Unbound"
/usr/sbin/unbound -d -c /etc/unbound/unbound.conf.d/pihole.conf &
# Get most recent process id for error checking
UNBOUND_PID=$!

# Wait for a second and check if unbound is running
sleep 1
if [ -d "/proc/$UNBOUND_PID" ]; 
then
    echo "  [i] Unbound started successfully."
else
    echo "  [i] Unbound startup failed."
    echo "  [i] Take a look at /var/log/unbound/unbound.log"
fi

# Start pi-hole
exec /usr/bin/start.sh