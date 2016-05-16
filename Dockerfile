FROM phusion/baseimage:0.9.18
MAINTAINER Dregu <dregu@dreg.us>
ENV DEBIAN_FRONTEND noninteractive
CMD ["/sbin/my_init"]
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y lib32gcc1 libstdc++6:i386 curl tmux bsdmainutils wget mailutils postfix
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
RUN useradd -m cs && chown cs:cs /home/cs -R && echo "cs ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN curl https://raw.githubusercontent.com/dgibbs64/linuxgsm/master/CounterStrikeGlobalOffensive/csgoserver > /home/cs/csgoserver
RUN chmod a+x /home/cs/csgoserver
RUN echo "cs ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER cs
WORKDIR /home/cs
RUN ./csgoserver auto-install
EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 27020/udp
EXPOSE 27005/udp
