FROM --platform=$TARGETOS/$TARGETARCH debian AS curl

# Install build dependencies
RUN apt update && apt install libssl-dev make g++ curl libpsl-dev -y

# Download curl source from https://curl.se/download/
RUN curl -o curl.tgz https://curl.se/download/curl-8.6.0.tar.gz

# Unpack
RUN tar xzvf curl.tgz

# Build
RUN cd curl-*/ && \
    ./configure --with-openssl --enable-websockets && \
    make && make install

FROM --platform=$TARGETOS/$TARGETARCH debian

LABEL org.opencontainers.image.source="https://github.com/kordlib/docker"
LABEL org.opencontainers.image.licenses=MIT

# https://github.com/ktorio/ktor/blob/6265a80481d77cdbb2ff7950750e8ee5aa085813/ktor-client/ktor-client-curl/desktop/interop/libcurl.def#L28C32-L28C42
COPY --from=curl /usr/local/lib/libcurl.a /usr/lib/libcurl.a
COPY --from=curl /usr/local/lib/libcurl.la /usr/lib/libcurl.la
COPY --from=curl /usr/local/lib/libcurl.so /usr/lib/libcurl.so
COPY --from=curl /usr/local/lib/libcurl.so.4 /usr/lib/libcurl.so.4
COPY --from=curl /usr/local/lib/libcurl.so.4.8.0 /usr/lib/libcurl.so.4.8.0

RUN apt update && apt install libssl3 ca-certificates psl -y
