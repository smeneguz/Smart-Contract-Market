FROM ubuntu:20.04
LABEL maintainer="Ocean Protocol <devops@oceanprotocol.com>"
RUN apt-get update && \
      apt-get -y install build-essential python3 git bash curl gcc g++ make
RUN curl -sL https://deb.nodesource.com/setup_18.x -o /tmp/nodesource_setup.sh
RUN bash /tmp/nodesource_setup.sh
RUN apt install nodejs
COPY . /ocean-contracts
WORKDIR /ocean-contracts
RUN rm package-lock.json
RUN rm -rf ./node-modules/
RUN npm i
ENV SLEEP_FOR_GANACHE=10
RUN cp hardhat.config.barge.js hardhat.config.js
ENV NETWORK=barge
ENV NETWORK_RPC_URL=127.0.0.1:8545
RUN npx hardhat compile
ENTRYPOINT ["/ocean-contracts/scripts/deploy_docker.sh"]
