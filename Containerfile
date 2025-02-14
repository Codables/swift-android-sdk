FROM ubuntu:24.04

LABEL org.opencontainers.image.source=https://github.com/codables/swift-android-sdk
LABEL org.opencontainers.image.description="Container for building Swift Android SDK"
LABEL org.opencontainers.image.licenses=Apache-2.0

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# Install OS-level dependencies
RUN apt-get -q update; \
    apt-get -q install -y \
    binutils \
    build-essential \
    clang \
    cmake \
    curl \
    git \
    gnupg2 \
    icu-devtools \
    libc++-18-dev \
    libc++abi-18-dev \
    libc6-dev \
    libcurl4-openssl-dev \
    libedit-dev \
    libedit2 \
    libgcc-13-dev \
    libicu-dev \
    libncurses-dev \
    libncurses5-dev \
    libpython3-dev \
    libsqlite3-0 \
    libsqlite3-dev \
    libstdc++-13-dev \
    libxml2-dev \
    libz3-dev \
    ninja-build \
    pkg-config \
    pkg-config \
    python3-pip \
    python3-pkg-resources \
    python3-psutil \
    python3-setuptools \
    python3-six \
    rsync \
    swig \
    systemtap-sdt-dev \
    tzdata \
    unzip \
    uuid-dev \
    zip \
    zlib1g-dev; \
    rm -r /var/lib/apt/lists/*

RUN groupadd -g 998 builder; \
    useradd -m -r -u 998 -g builder builder
USER builder
WORKDIR /home/builder

# Android NDK, changes less frequently than Swift version
ARG ANDROID_NDK_VERSION=27c
ARG ANDROID_NDK_SHA=090e8083a715fdb1a3e402d0763c388abb03fb4e
ENV ANDROID_NDK_ROOT=/home/builder/android-ndk-r${ANDROID_NDK_VERSION}

RUN set -eux; \
    ANDROID_NDK_ZIP=android-ndk-r${ANDROID_NDK_VERSION}-linux.zip; \
    curl -s -O https://dl.google.com/android/repository/${ANDROID_NDK_ZIP}; \
    echo "${ANDROID_NDK_SHA} ${ANDROID_NDK_ZIP}" | sha1sum -c - ; \
    unzip ${ANDROID_NDK_ZIP}; \
    rm ${ANDROID_NDK_ZIP}
