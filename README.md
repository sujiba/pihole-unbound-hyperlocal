# Pihole + Unbound + Hyperlocal

> [!NOTE]
>
> **IMPORTANT**: When using this Docker image, please report any bugs or suggestions to this repository directly.


## Upgrade Notes

> [!CAUTION]
> 
> ## !!! THE LATEST VERSION CONTAINS BREAKING CHANGES
>
> **Pi-hole v6 has been entirely redesigned from the ground up and contains many breaking changes.**
> 
> Read https://github.com/pi-hole/docker-pi-hole

> [!tip]
> Firstly pull the new image with `docker pull ghcr.io/sujiba/pihole-unbound-hyperlocal:2025.03.0`.
> Then stop the old container. 
> Follow the steps described bellow. For the transition you're going to have two folders
> - old: pihole-unbound-hyperlocal
> - new: pihole-unbound-hyperlocal-v6
> 
> When everything is running, you can delete the old folder.

## Overview 

- [Pihole + Unbound + Hyperlocal](#pihole--unbound--hyperlocal)
  - [Overview](#overview)
  - [Acknowledgement](#acknowledgement)
  - [Introduction](#introduction)
  - [Prerequisites](#prerequisites)
  - [First startup](#first-startup)
    - [Testing](#testing)
  - [DNS problems](#dns-problems)
  - [Blocklists](#blocklists)

## Acknowledgement
- [Docker Pi-hole](https://github.com/pi-hole/docker-pi-hole)
- [Unbound](https://nlnetlabs.nl/projects/unbound/about/)
- [Pi-hole Unbound](https://docs.pi-hole.net/guides/dns/unbound/)
- [mpgirro/docker-pihole-unbound](https://github.com/mpgirro/docker-pihole-unbound)
- [Pi-hole: Einrichtung und Konfiguration mit unbound – AdBlocker Teil2](https://www.kuketz-blog.de/pi-hole-einrichtung-und-konfiguration-mit-unbound-adblocker-teil2/)

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

## First startup
Clone the repository to your favored location and change the config.
```
git clone -b main https://github.com/sujiba/pihole-unbound-hyperlocal.git pihole-unbound-hyperlocal-v6

# Change the timezone, password and other pi-hole settings
cp example.pihole.env pihole.env
vi pihole.env

# Change the ports if you're running a reverse proxy on ports 80 and 443
vi compose.yml
```

Start the container
```
docker compose up -d
```

Check the logs
```
docker compose logs -f
```

### Testing
```
docker compose exec -it pihole-unbound sh
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
- [hagezi dns-blocklists](https://github.com/hagezi/dns-blocklists)
