FROM alpine:3.16

ENV LANG="C.UTF-8" \
    PS1="\[\e[32m\][\[\e[m\]\[\e[36m\]\u \[\e[m\]\[\e[37m\]@ \[\e[m\]\[\e[34m\]\h\[\e[m\]\[\e[32m\]]\[\e[m\] \[\e[37;35m\]in\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[32m\][\[\e[m\]\[\e[37m\]\d\[\e[m\] \[\e[m\]\[\e[37m\]\t\[\e[m\]\[\e[32m\]]\[\e[m\] \n\[\e[1;31m\]$ \[\e[0m\]" \
    DEBUG="false" \
    SERVERPATH="//192.168.1.1/example" \
    MOUNTPOINT="/mnt/smb" \
    MOUNTOPTIONS="vers=3.1.1,uid=1000,gid=1000,rw,username=user,password=example" \
    UMOUNTOPTIONS="-a -t cifs -l" \
    AccessFolder="/mnt"

RUN apk add --no-cache \
        cifs-utils \
        bash \
        ca-certificates \
        grep \
        s6-overlay \
    && \
    rm -rf \
        /tmp/* \
        /var/cache/apk/* \
        /var/lib/apk/lists/*

COPY rootfs/ /

ENTRYPOINT ["/init"]

# HEALTHCHECK --interval=5s --timeout=2s --retries=20 CMD /healthcheck.sh || exit 1
