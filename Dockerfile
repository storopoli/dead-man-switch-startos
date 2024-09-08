# Start from the official Rust image
FROM rust:latest AS builder

# Set the working directory
WORKDIR /usr/src/app

# Add labels for OCI annotations
LABEL org.opencontainers.image.source="https://github.com/storopoli/dead-man-switch" \
    org.opencontainers.image.description="Dead Man's Switch" \
    org.opencontainers.image.licenses="AGPLv3"

# Copy project's source
COPY ./dead-man-switch/Cargo.toml ./
COPY ./dead-man-switch/Cargo.lock ./
COPY ./dead-man-switch/crates ./crates

# Build application for release target
RUN cargo build -p dead-man-switch-web --release

# Start a new stage from a slim version of Debian to reduce the size of the final image
FROM debian:bookworm-slim

# Install libssl3 and wget
RUN apt-get update && apt-get install -y libssl3 wget && apt clean && rm -rf /var/lib/apt/lists/*

# Install yq
RUN wget https://github.com/mikefarah/yq/releases/download/v4.44.3/yq_linux_amd64.tar.gz -O - |\
    tar xz && mv yq_linux_amd64 /usr/bin/yq && chmod +x /usr/bin/yq

# Copy the binary from the builder stage to the new stage
COPY --from=builder /usr/src/app/target/release/dead-man-switch-web /usr/local/bin/dead_man_switch_web

# Expose port 3000
EXPOSE 3000

RUN chmod +x /usr/local/bin/dead_man_switch_web
ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
