FROM ubuntu:24.04 AS build

ARG MSQUIC_VERSION=v2.6.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential ca-certificates cmake git perl \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch "${MSQUIC_VERSION}" https://github.com/microsoft/msquic /msquic \
    && cd /msquic \
    && git submodule update --init --depth 1 submodules/quictls

WORKDIR /msquic/build

RUN cmake \
        -DATOMIC="$(gcc -print-file-name=libatomic.a)" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_EXE_LINKER_FLAGS=-static \
        -DQUIC_BUILD_PERF=ON \
        -DQUIC_BUILD_SHARED=OFF \
        .. \
    && cmake --build . --target secnetperf --parallel "$(nproc)" \
    && ! readelf --program-headers bin/Release/secnetperf | grep -q INTERP \
    && ! readelf --dynamic bin/Release/secnetperf | grep -q NEEDED

FROM scratch AS binary

COPY --from=build /msquic/build/bin/Release/secnetperf /secnetperf

FROM ubuntu:24.04

LABEL org.opencontainers.image.source=https://github.com/firezone/secnetperf

COPY --from=binary /secnetperf /usr/local/bin/secnetperf

CMD ["secnetperf"]
