
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
RUN wget https://releases.parity.io/v2.1.3/x86_64-unknown-linux-gnu/parity
RUN chmod +x parity
RUN mv parity /usr/bin/
# docker run --name=paritydata -v /paritydata busybox chown 1000:1000 /paritydata
RUN mkdir /paritydata
EXPOSE 30303 8541 8542
ENTRYPOINT ["/usr/bin/parity", \
            "--port", "30303", \
            "--jsonrpc-port", "8541", \
            "--ws-port", "8542", \
            "-d", "/paritydata", \
            "--pruning", "archive", \
            "--tracing", "on", \
            "--scale-verifiers", \
            "--no-ui", \
            "--no-dapps", \
            "--no-hardware-wallets", \
            "--no-secretstore", \
            "--no-secretstore-http", \
            "--ws-apis", "web3,eth,pubsub,net,parity,parity_pubsub,traces,rpc,secretstore,shh,shh_pubsub", \
            "--ws-origins", "all", \
            "--ws-interface", "all", \
            "--ws-hosts", "all", \
            "--jsonrpc-hosts", "all", \
            "--jsonrpc-interface", "all", \
            "--jsonrpc-cors", "'*'", \
            "--jsonrpc-apis", "safe", \
            "--tx-queue-mem-limit", "0", \
            "--tx-queue-size", "4294967295", \
            "--cache-size", "16384", \
            "--jsonrpc-server-threads", "10", \
            "--jsonrpc-threads", "10"]
