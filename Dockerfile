FROM busybox AS builder

RUN wget https://github.com/docker/buildx/releases/download/v0.2.2/buildx-v0.2.2.linux-amd64 -O /tmp/docker-buildx

FROM docker:git

COPY --from=builder /tmp/docker-buildx /usr/lib/docker/cli-plugins/docker-buildx

RUN chmod a+x /usr/lib/docker/cli-plugins/docker-buildx && \
    mkdir -p /etc/docker && \
    echo '{' > /etc/docker/daemon.json && \
    echo '    "experimental": true' >> /etc/docker/daemon.json && \
    echo '}' >> /etc/docker/daemon.json
