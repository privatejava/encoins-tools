# For creating encoins relay server docker container
FROM ubuntu:22.04 as builder

ARG ENCOINS_RELAY_VERSION

RUN mkdir -p "$HOME/.local/bin/" && \
    export PATH="$HOME/.local/bin/:$PATH" && \ 
    echo "export PATH='$HOME/.local/bin/:$PATH'" >> ~/.bashrc

RUN apt update && \
    apt install automake build-essential curl pkg-config \
    libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev \
    zlib1g-dev make g++ tmux git jq wget libtool autoconf libpq-dev -y

RUN apt install git && \
    mkdir -p ~/cardano-src && \
    export CARDANO_SRC_PATH=~/cardano-src && \
    cd $CARDANO_SRC_PATH && \
    git clone https://github.com/input-output-hk/libsodium && \
    cd libsodium && \
    git checkout dbb48cc && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

RUN echo $CARDANO_SRC_PATH && \
    cd $CARDANO_SRC_PATH && \
    git clone https://github.com/bitcoin-core/secp256k1 && \
    cd secp256k1 && \
    git checkout ac83be33 && \
    ./autogen.sh && \
    ./configure --enable-module-schnorrsig --enable-experimental && \
    make && \
    make check && \
    make install


RUN cd $CARDANO_SRC_PATH && \
    wget https://github.com/encryptedcoins/encoins-relay/releases/download/v1.2.1/encoins && \
    mv encoins "$HOME/.local/bin/" && \
    rm -f -r $CARDANO_SRC_PATH && \
    cd ~ && \
    git clone https://github.com/encryptedcoins/encoins-tools.git && \
    export ENCOINS_TOOLS_PATH=~/encoins-tools
    
FROM ubuntu:22.04 

WORKDIR /app

ENV PATH="$PATH:/root/.local/bin"
ENV LC_ALL=C.UTF-8

RUN apt update && \
    apt install curl libpq5 jq -y

COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/include /usr/local/include
COPY --chmod=777 --from=builder /root/.local/bin /root/.local/bin
COPY . /app
COPY --chmod=777 docker/relay-init.sh init.sh

CMD ["/app/init.sh"]


# army gasp metal visual party radio harbor jump position myth file rescue minute race floor fragile six risk country alone rent thought issue apple