
FROM ubuntu:16.04
MAINTAINER Moe Adham <moe@bitaccess.co>

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        libudev-dev \
        python \
        rsync \
        software-properties-common \
        git-core \
        wget \
        libzmq3-dev \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Install parity
RUN wget http://parity-downloads-mirror.parity.io/v1.8.0/x86_64-unknown-linux-gnu/parity_1.8.0_amd64.deb
RUN dpkg -i parity_1.8.0_amd64.deb
RUN mkdir /paritydata
EXPOSE 30303 8541 8542
ENTRYPOINT ["parity", \
            "--port", "30303", \
            "--jsonrpc-port", "8541", \
            "--ws-port", "8542", \
            "-d", "/paritydata", \
            "--no-ui", \
            "--ws-apis", "web3,eth,pubsub,net", \
            "--ws-origins", "all", \
            "--ws-hosts", "all", \
            "--jsonrpc-hosts", "all", \
            "--jsonrpc-cors", "'*'", \
            "--jsonrpc-apis", "eth,net,web3", \
            "--jsonrpc-threads", "4", \
            "--jsonrpc-server-threads", "4", \
            "--no-dapps", \
            "--no-secretstore", \
            "--public-node"]
