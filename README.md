# Pihole + Unbound + Hyperlocal

**IMPORTANT**: When using this Docker image, please report any bugs or suggestions to this repository directly.

## Overview 

- [Pihole + Unbound + Hyperlocal](#pihole--unbound--hyperlocal)
  - [Overview](#overview)
  - [Introduction](#introduction)
  - [Prerequisites](#prerequisites)
  - [First startup](#first-startup)
    - [resolv.conf](#resolvconf)
    - [Testing](#testing)
  - [DNS problems](#dns-problems)
  - [Blocklists](#blocklists)
  - [Acknowledgement](#acknowledgement)

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
Check the logs
```
docker-compose logs -f
```

### resolv.conf
If you get the following error

```
pihole  | Starting unbound
pihole  |   [✗] DNS resolution is currently unavailable
```

uncomment the following line in the docker-compose.yaml

```
#- ./resolv.conf:/etc/resolv.conf
```

and restart the container

```
docker-compose up -d --force-recreate
```

### Testing
```
docker exec -it pihole-unbound bash
dig github.com @127.0.0.1 +short
dig sigfail.verteiltesysteme.net @127.0.0.1 | grep status 
dig sigok.verteiltesysteme.net @127.0.0.1 | grep status
```
- First dig should show an IP address
- Second dig should show status: SERVFAIL
- Last dig should show status: NOERROR

## DNS problems
If you are running other docker containers on the same host and cannot use name resolution within these containers, you have to modify /etc/resolvconf.conf on your host system and uncomment the following:
```
# If you run a local name server, you should uncomment the below line and
# configure your subscribers configuration files below.
name_servers=127.0.0.1
```
Write the changes to your resolv.conf:
```
sudo resolvconf -u
```
See also [StackExchange](https://unix.stackexchange.com/questions/647996/docker-container-dns-not-working-with-pihole)

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
