# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Update package lists and install chrony
RUN apt-get update && \
    apt-get install -y chrony && \
    # Clean up to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY chrony.conf /etc/chrony/chrony.conf

EXPOSE 123/udp

ENTRYPOINT ["chronyd", "-d", "-f", "/etc/chrony/chrony.conf"]

HEALTHCHECK --interval=30s --timeout=3s \
    CMD chronyc tracking || exit 1
