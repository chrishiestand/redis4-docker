FROM alpine:3.6

CMD ["/usr/local/bin/redis-server", "--dir", "/var/lib/redis"]

RUN apk --no-cache --update add \
        autoconf \
        g++ \
        gcc \
        git \
        jemalloc-dev \
        linux-headers \
        make \
    && \
    git clone --branch 4.0-rc3 https://github.com/antirez/redis.git /tmp/redis && \
    cd /tmp/redis && \
    make && \
    make install && \
    rm -rf /tmp/* && \
    apk del \
        autoconf \
        g++ \
        gcc \
        git \
        jemalloc-dev \
        linux-headers \
        make \
    && \
    mkdir /var/lib/redis && \
    chown guest /var/lib/redis

USER guest
