#!/bin/bash
set -eux

BUNDLE_ROOT="${PWD}/sdk-build/swift-android.artifactbundle/"
SDK_ROOT="${BUNDLE_ROOT}/Android29.sdk"

cat > "${BUNDLE_ROOT}/info.json" <<EOF
{
  "schemaVersion": "1.0",
  "artifacts": {
    "Android29.sdk": {
      "type": "swiftSDK",
      "variants": [
        {
          "path": "Android29.sdk"
        }
      ],
      "version": "0.0.1"
    }
  }
}
EOF

cat > "${SDK_ROOT}/swift-sdk.json" <<EOF
{
    "schemaVersion": "4.0",
    "targetTriples": {
        "aarch64-unknown-linux-android29": {
            "sdkRootPath": "aarch64-unknown-linux-android29",
            "swiftResourcesPath": "aarch64-unknown-linux-android29/usr/lib/swift",
            "swiftStaticResourcesPath": "aarch64-unknown-linux-android29/usr/lib/swift_static-aarch64",
            "toolsetPaths": [
                "toolset.json"
            ]
        }
    }
}
EOF

cat > "${SDK_ROOT}/toolset.json" <<EOF
{
    "schemaVersion": "1.0",
    "cCompiler": {
        "extraCLIOptions": [
            "-fPIC"
        ]
    },
    "swiftCompiler": {
        "extraCLIOptions": [
            "-Xclang-linker",
            "-fuse-ld=lld"
        ]
    }
}
EOF
