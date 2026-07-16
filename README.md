# secnetperf

Packages [`secnetperf`](https://github.com/microsoft/msquic/tree/main/src/perf), msquic's performance measurement tool, because the msquic project publishes neither prebuilt binaries nor images for it.

The build produces standalone Linux and Windows x86-64 binaries with msquic linked statically. Every push to `main` publishes:

- `ghcr.io/firezone/secnetperf`, tagged `latest` and with the pinned msquic version.
- A GitHub release named after the pinned msquic version, containing both binaries and their SHA-256 checksums. Its assets are refreshed on every push and may change without a new release tag.

A nightly workflow opens a PR to bump the pinned version when msquic publishes a new release.

Used by the performance tests in [firezone/firezone](https://github.com/firezone/firezone).
