# Pihole + Unbound + Hyperlocal

**IMPORTANT**: When using this Docker image, please report any bugs or suggestions to us directly.

### Overview
- [Introduction](https://github.com/sujiba/pihole-unbound-hyperlocal#introduction)
- [Prerequisites](https://github.com/sujiba/pihole-unbound-hyperlocal#prerequisites)
- [First startup](https://github.com/sujiba/pihole-unbound-hyperlocal#first-startup)
  - [Testing](https://github.com/sujiba/pihole-unbound-hyperlocal#testing)
  - [Additional configuration](https://github.com/sujiba/pihole-unbound-hyperlocal#additional-configuration)
- [Blocklists](https://github.com/sujiba/pihole-unbound-hyperlocal#blocklists)
- [Acknowledgement](https://github.com/sujiba/pihole-unbound-hyperlocal#acknowledgement)

## Introduction
**Pi-hole**:
- Pi-hole is a DNS sinkhole that protects your devices from unwanted content, without installing any client-side software.

**Unbound**:
- Unbound is a validating, recursive, caching DNS resolver. It is designed to be fast and lean and incorporates modern features based on open standards. 

**Hyperlocal**:
- To spare the initial DNS query to the DNS-Root-Servers by Unbound, we provide Unbound with an appropriate configuration. With each Pi-hole update, the DNS-Root-Zone (root.hints) is also updated. 

## Prerequisites
- Install [Docker](https://docs.docker.com/get-docker/)
- Install [Docker-Compose](https://docs.docker.com/compose/install/)
- Download the repository to your favored directory

## First startup
Copy example.env to .env and change the parameters
```
cp example.env .env
vi .env
```
Start the container
```
docker-compose up -d
```

### Testing
```
docker exec -it pihole bash
dig github.com @127.0.0.1 +short
dig sigfail.verteiltesysteme.net @127.0.0.1 | grep status 
dig sigok.verteiltesysteme.net @127.0.0.1 | grep status 
```
- First dig should show an IP address
- Second dig should show status: SERVFAIL
- Last dig should show status: NOERROR

### Additional configuration
Edit setupVars.conf
```
vi ./etc-pihole/setupVars.conf
```
and add
```
# Caching is done by unbound
CACHE_SIZE=0
```

#### Self-created docker network
If you are using a self-created docker network, uncomment the following line in the docker-compose.yaml
```
#- ./resolv.conf:/etc/resolv.conf
```

### Restart the container
```
docker-compose up -d --force-recreate
```

## Blocklists
- [Firebog Non-crossed lists](https://v.firebog.net/hosts/lists.php?type=nocross)
- [x0uid SpotifyAdBlock](https://raw.githubusercontent.com/x0uid/SpotifyAdBlock/master/SpotifyBlocklist.txt)
- [Perflyst SmartTV](https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt)
- [mmotti Pi-hole RegEx](https://raw.githubusercontent.com/mmotti/pihole-regex/master/regex.list)
- [Privacy-Handbuch Windows 10 Telemetry](https://www.privacy-handbuch.de/handbuch_90a2.htm)

## Acknowledgement
- [Docker Pi-hole](https://github.com/pi-hole/docker-pi-hole)
- [Unbound](https://nlnetlabs.nl/projects/unbound/about/)
- [Pi-hole Unbound](https://docs.pi-hole.net/guides/dns/unbound/)
- [Pi-Hole + Unbound - 1 Container](https://github.com/chriscrowe/docker-pihole-unbound/tree/master/one-container)
- [[Pi-hole][Unbound] Mit dem Pi zur größtmöglichen Unabhängigkeit – DNS](https://forum.kuketz-blog.de/viewtopic.php?f=53&t=8759)
