# use ubuntu 24.04 as the base image
FROM ubuntu:24.04

#build time
ARG BUILD_DATE

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.authors="ftflstwd <ftflstwd@faithfulsteward.tech>" \
      org.opencontainers.image.documentation=https://github.com/ftflstwd/docker-chrony

# update package lists and install chrony
RUN apt-get update && \
    apt-get install -y chrony ca-certificates && \
# clean up to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY chrony.conf /etc/chrony/chrony.conf

EXPOSE 123/udp

ENTRYPOINT ["chronyd", "-x", "-d", "-f", "/etc/chrony/chrony.conf"]

HEALTHCHECK --interval=30s --timeout=3s CMD chronyc tracking || exit 1
