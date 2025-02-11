#!/bin/bash
set -eux

ndk_version=${NDK_VERSION:?android ndk version is required}
ndk_sha1=${NDK_SHA1:?android ndk sha1sum is required}

ndk_zip=android-ndk-r${ndk_version}-linux.zip;
curl -s -O "https://dl.google.com/android/repository/${ndk_zip}"
echo "${ndk_sha1} ${ndk_zip}" | sha1sum -c -
unzip "${ndk_zip}"
rm "${ndk_zip}"

echo ANDROID_NDK_ROOT="${PWD}/android-ndk-r${ndk_version}"
