FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV BDB_PREFIX=/db4

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential libtool autotools-dev automake \
    pkg-config libssl-dev libevent-dev bsdmainutils \
    libboost-system-dev libboost-filesystem-dev \
    libboost-chrono-dev libboost-program-options-dev \
    libboost-test-dev libboost-thread-dev \
    git wget \
    && rm -rf /var/lib/apt/lists/*

# Install Berkeley DB
RUN mkdir -p $BDB_PREFIX \
    && wget 'https://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz' \
    && tar -xzvf db-4.8.30.NC.tar.gz \
    && cd db-4.8.30.NC/build_unix \
    && ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$BDB_PREFIX \
    && make -j$(nproc) \
    && make install \
    && cd / \
    && rm -rf db-4.8.30.NC*

# Clone and build Bitcoin SV
RUN git clone https://github.com/bitcoin-sv/bitcoin-sv.git \
    && cd bitcoin-sv \
    && git checkout v1.0.11 \
    && ./autogen.sh \
    && ./configure LDFLAGS="-L${BDB_PREFIX}/lib/" CPPFLAGS="-I${BDB_PREFIX}/include/" \
    && make -j$(nproc)

EXPOSE 18332 18333 28332

ENTRYPOINT ["/bitcoin-sv/src/bitcoind"]
