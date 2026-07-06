# secnetperf

Packages [`secnetperf`](https://github.com/microsoft/msquic/tree/main/src/perf), msquic's performance measurement tool, as a container image because the msquic project publishes neither prebuilt binaries nor images for it.

Every push to `main` builds and publishes `ghcr.io/firezone/secnetperf`, tagged `latest` and with the pinned msquic version. A nightly workflow opens a PR to bump the pinned version when msquic publishes a new release.

Used by the performance tests in [firezone/firezone](https://github.com/firezone/firezone).
