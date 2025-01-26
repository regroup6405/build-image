FROM quay.io/fedora/fedora:41

COPY --from=ghcr.io/sigstore/cosign/cosign:v2 /ko-app/cosign /usr/local/bin/cosign

COPY --from=docker.io/mikefarah/yq:latest /usr/bin/yq /usr/bin/yq

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
    jq \
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
    && dnf clean all -y \
    && rm -rf /tmp/*
