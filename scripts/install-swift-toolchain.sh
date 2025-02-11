#!/bin/bash
set -eux

swift_tag=${SWIFT_TAG:?swift tag is required}
swift_webroot=https://download.swift.org/development/ubuntu2404

curl -fsSL "${swift_webroot}/${swift_tag}/${swift_tag}-ubuntu24.04.tar.gz" -o swift-toolchain.tar.gz
curl -fsSL "${swift_webroot}/${swift_tag}/${swift_tag}-ubuntu24.04.tar.gz.sig" -o swift-toolchain.tar.gz.sig

mkdir swift-toolchain
tar xzf swift-toolchain.tar.gz -C swift-toolchain --strip-components 1
rm swift-toolchain.tar.gz*

export PATH=${PWD}/swift-toolchain/usr/bin:${PATH}

swift -version