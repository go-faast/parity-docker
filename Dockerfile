
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
RUN wget http://parity-downloads-mirror.parity.io/v1.7.0/x86_64-unknown-linux-gnu/parity_1.7.0_amd64.deb
RUN dpkg -i parity_1.7.0_amd64.deb
RUN mkdir /paritydata
EXPOSE 30303 8541
#ENTRYPOINT "parity -d /paritydata --no-ui --port 30303 --jsonrpc-port 8541 --jsonrpc-hosts all --jsonrpc-cors '*' --jsonrpc-apis eth,net,web3 --no-dapps --no-secretstore --no-code --no-storage"
ENTRYPOINT ["parity", \
            "-d", \
            "/paritydata", \
            "--no-ui", \
            "--port", \
            "30303", \
            "--jsonrpc-port", "8541", \
            "--jsonrpc-hosts", "all", \
            "--jsonrpc-cors", "'*'", \
            "--jsonrpc-apis", "eth,net,web3", \
            "--no-dapps", \
            "--no-secretstore", \
            "--no-code", \
            "--no-storage"]
