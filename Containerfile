FROM fedora:41

COPY --from=gcr.io/projectsigstore/cosign:v2@sha256:4c42b1122d79bef6e333c33510a4228d5c4e69875f28288e5a6bef3e299561f8 /ko-app/cosign /usr/local/bin/cosign

COPY --from=docker.io/mikefarah/yq:latest@sha256:2c100efaca06e95ffe452cfe9bfc0048b493f0f3a072d5fe06f828c638d9462b /usr/bin/yq /usr/bin/yq

COPY --from=docker.io/docker/compose-bin:latest@sha256:2f9a25e681af058b800a39f7f6bc847d7933f06bbc1acd93479d2a2a40d0fa7a /docker-compose /docker-compose

COPY --from=docker/buildx-bin@sha256:ead27bfcde6308a757b4a5a4a931937363c1fa0091f7e2994b9114521853cf69 /buildx /usr/libexec/docker/cli-plugins/docker-buildx

COPY xidel /usr/bin/xidel

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
