FROM quay.io/fedora/fedora:43

COPY --from=ghcr.io/sigstore/cosign/cosign:v2.4.1 /ko-app/cosign /usr/local/bin/cosign

COPY --from=docker/buildx-bin /buildx /usr/libexec/docker/cli-plugins/docker-buildx

COPY xidel /usr/bin/xidel
RUN chmod +x /usr/bin/xidel

RUN sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/fedora-cisco-openh264.repo

RUN dnf update -y && dnf install -y --nodocs --setopt install_weak_deps=False \
    bc \
    bind-utils \
    butane \
    coreos-installer \
    curl \
    dos2unix \
    git \
    iproute \
    moby-engine \
    net-tools \
    openssl \
    openssh-clients \
    python3-pip \
    iputils \
    shellcheck \
    sshpass \
    which \
    wget \
    yt-dlp \
    && pip install selenium \
    && curl --fail -sSL -o "/usr/bin/jq" "https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-linux-amd64" \
    && chmod +x /usr/bin/jq \
    && curl --fail -sSL -o "/usr/bin/yq" "https://github.com/mikefarah/yq/releases/download/v4.49.2/yq_linux_amd64" \
    && chmod +x /usr/bin/yq \
    && dnf clean all -y \
    && rm -rf /tmp/*
