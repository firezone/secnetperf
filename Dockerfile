FROM ubuntu:24.04 AS build

ARG MSQUIC_VERSION=v2.5.8

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential ca-certificates cmake git perl \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch "${MSQUIC_VERSION}" https://github.com/microsoft/msquic /msquic \
    && cd /msquic \
    && git submodule update --init --depth 1 submodules/quictls

WORKDIR /msquic/build

RUN cmake -DCMAKE_BUILD_TYPE=Release -DQUIC_BUILD_PERF=ON .. \
    && cmake --build . --parallel "$(nproc)"

FROM ubuntu:24.04

LABEL org.opencontainers.image.source=https://github.com/firezone/secnetperf

COPY --from=build /msquic/build/bin/Release/secnetperf /usr/local/bin/secnetperf
COPY --from=build /msquic/build/bin/Release/libmsquic.so.2 /usr/local/lib/libmsquic.so.2

RUN ldconfig

CMD ["secnetperf"]
