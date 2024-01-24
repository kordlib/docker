FROM alpine AS curl

# Install build dependencies
RUN apk add openssl-dev make g++ curl

# Download curl source from https://curl.se/download/
RUN curl -o curl.tgz https://curl.se/download/curl-8.5.0.tar.gz

# Unpack
RUN  tar xzvf curl.tgz --strip-components=1

# Configure
RUN ./configure --with-openssl --enable-websockets

# Compile
RUN make && make install

FROM alpine

# See https://youtrack.jetbrains.com/issue/KT-38876/#focus=Comments-27-4805258.0-0
RUN apk add gcompat
# https://github.com/ktorio/ktor/blob/6265a80481d77cdbb2ff7950750e8ee5aa085813/ktor-client/ktor-client-curl/desktop/interop/libcurl.def#L28C32-L28C42
COPY --from=curl /usr/local/lib/libcurl.a /usr/lib/libcurl.a
COPY --from=curl /usr/local/lib/libcurl.la /usr/lib/libcurl.la
COPY --from=curl /usr/local/lib/libcurl.so /usr/lib/libcurl.so
COPY --from=curl /usr/local/lib/libcurl.so.4 /usr/lib/libcurl.so.4
COPY --from=curl /usr/local/lib/libcurl.so.4.8.0 /usr/lib/libcurl.so.4.8.0

