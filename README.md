# secnetperf

Packages [`secnetperf`](https://github.com/microsoft/msquic/tree/main/src/perf), msquic's performance measurement tool, because the msquic project publishes neither prebuilt binaries nor images for it.

The build produces standalone Linux and Windows x86-64 binaries and a macOS Apple Silicon binary with msquic and TLS linked statically. The macOS binary requires macOS 13 or newer and only uses system dynamic libraries. Every push to `main` publishes:

- `ghcr.io/firezone/secnetperf`, tagged `latest` and with the pinned msquic version.
- A GitHub release named after the pinned msquic version, containing all three binaries and their SHA-256 checksums. Its assets are refreshed on every push and may change without a new release tag.

A nightly workflow opens a PR to bump the pinned version when msquic publishes a new release.

Used by the performance tests in [firezone/firezone](https://github.com/firezone/firezone).

## macOS

Download `secnetperf-aarch64-apple-darwin` and its `.sha256sum.txt` file from the
[latest release](https://github.com/firezone/secnetperf/releases/latest), then verify
and install them:

```sh
shasum -a 256 -c secnetperf-aarch64-apple-darwin.sha256sum.txt
sudo install -m 0755 secnetperf-aarch64-apple-darwin /usr/local/bin/secnetperf
```

No Homebrew runtime dependencies are needed. CI verifies the binary's dependencies
and runs QUIC upload and download tests over loopback. Pull requests also provide
the binary and checksum in the `secnetperf-macos-arm64` workflow artifact.
