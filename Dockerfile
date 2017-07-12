FROM alpine:3.6

ENV RELEASE=4.0-rc3

WORKDIR /var/lib/redis

RUN apk --no-cache add \
        --virtual build-dependencies \
          autoconf \
          g++ \
          gcc \
          git \
          jemalloc-dev \
          linux-headers \
          make && \
    git clone --depth=1 --branch ${RELEASE} https://github.com/antirez/redis.git /tmp/redis/&& \
    cd /tmp/redis && \
    make -j && \
    make install && \
    cp /tmp/redis/src/redis-trib.rb /usr/local/bin && \
    rm -rf /tmp/redis && \
    chown guest /var/lib/redis && \
    apk del build-dependencies

USER guest

EXPOSE 6379

ENTRYPOINT ["/usr/local/bin/redis-server"]
CMD ["--dir", "/var/lib/redis"]
