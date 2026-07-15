# secnetperf

Packages [`secnetperf`](https://github.com/microsoft/msquic/tree/main/src/perf), msquic's performance measurement tool, because the msquic project publishes neither prebuilt binaries nor images for it.

The build statically links msquic and its runtime dependencies into a standalone Linux x86-64 binary. Every push to `main` publishes:

- `ghcr.io/firezone/secnetperf`, tagged `latest` and with the pinned msquic version.
- A GitHub release named after the pinned msquic version, containing the binary and its SHA-256 checksum. Its assets are refreshed on every push and may change without a new release tag.

A nightly workflow opens a PR to bump the pinned version when msquic publishes a new release.

Used by the performance tests in [firezone/firezone](https://github.com/firezone/firezone).
