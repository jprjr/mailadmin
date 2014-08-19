FROM jprjr/arch
MAINTAINER John Regan <john@jrjrtech.com>

RUN pacman -Syy >/dev/null 2>/dev/null && \
    pacman -S --needed --asdeps --noconfirm base-devel && \
    pacman -S --needed --quiet --noconfirm cpanminus perl \
      perl-dbd-mysql perl-dbd-pg perl-dbd-sqlite \
      perl-term-readkey openssh >/dev/null 2>/dev/null && \
    /usr/bin/vendor_perl/cpanm IO::Prompter && \
    pacman -Ru --noconfirm cpanminus && \
    pacman -R --noconfirm $(pacman -Qdtq) && \
    paccache -rk0 && \
    pacman -Scc --noconfirm && \
    rm -rf /etc/ssh/* && \
    mkdir /opt/ssh.default

RUN useradd -m mailadmin && \
    usermod -p mailadmin mailadmin && \
    passwd -u mailadmin

COPY conf/sshd_config /opt/ssh.default/sshd_config
COPY script/mailadmin /usr/local/bin/mailadmin

RUN mkdir -p /etc/s6/sshd && \
    ln -s /bin/true /etc/s6/sshd/finish && \
    mkdir -p /etc/s6/.s6-svscan && \
    ln -s /bin/true /etc/s6/.s6-svscan/finish

COPY sshd.setup /etc/s6/sshd/setup
COPY sshd.run /etc/s6/sshd/run

EXPOSE 22

ENTRYPOINT ["/usr/bin/s6-svscan","/etc/s6"]
CMD []
