FROM arm32v7/ubuntu

MAINTAINER Houzuo Guo <guohouzuo@gmail.com>

COPY qemu-arm-static-1:2.11+dfsg-1ubuntu7.9 /usr/bin/qemu-arm-static

ARG http_proxy
ARG https_proxy
ARG socks_proxy
ARG all_proxy

ENV http_proxy=$http_proxy
ENV https_proxy=$https_proxy
ENV socks_proxy=$socks_proxy
ENV all_proxy=$all_proxy

WORKDIR /

# Upgrade system packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y && apt upgrade -q -y -f -m -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-confdef

# Install diagnosis utilities
RUN apt install -q -y -f -m -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-confdef bash busybox curl dateutils diffutils dnsutils finger fish gdb hostname htop iftop iotop iputils-ping language-pack-en lftp locales locales-all lsof mailutils moreutils netcat net-tools nmap nmon patchutils procps psmisc rsync screen snmp strace sudo tcpdump tcptraceroute telnet tmux traceroute tree tshark unar unzip util-linux-locales vim wget whois wiggle zip

# Remove unnecessary files
RUN rm -rf /var/cache/apt/*

# Entry point is fish shell
ENTRYPOINT ["/usr/bin/fish", "-l"]
