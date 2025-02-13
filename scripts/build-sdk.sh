#!/bin/bash
set -eux

arch=${1:?"architecture must be set"}
triple=${arch}-unknown-linux-android29

SDK_ROOT="${PWD}/sdk-build/swift-android.artifactbundle/Android29.sdk/${triple}"
mkdir -p "${SDK_ROOT}"

SWIFT_TOOLCHAIN="${PWD}/swift-toolchain"

./source/swift/utils/build-script \
    -RA \
    --build-llvm=0 \
    --build-swift-tools=0 \
    --skip-build-cmark \
    --skip-local-build \
    --skip-early-swiftsyntax \
    --skip-early-swift-driver \
    --build-swift-static-stdlib \
    --android \
    --android-ndk "${ANDROID_NDK_ROOT}" \
    --android-arch "${arch}" \
    --android-api-level 29 \
    --cross-compile-append-host-target-to-destdir=False \
    --cross-compile-hosts=android-"${arch}" \
    --native-swift-tools-path="${SWIFT_TOOLCHAIN}/usr/bin" \
    --native-clang-tools-path="${SWIFT_TOOLCHAIN}/usr/bin" \
    --skip-early-swift-driver \
    --install-swift \
    --install-libdispatch \
    --install-destdir="${SDK_ROOT}" \
    '--swift-install-components=compiler;license;stdlib;sdk-overlay'
