FROM ubuntu:19.04
ARG DEBIAN_FRONTEND=noninteractive

# IceStorm and friends
RUN apt-get update && apt-get install -y \
        build-essential clang bison flex libreadline-dev \
        gawk tcl-dev libffi-dev git mercurial graphviz   \
        xdot pkg-config python python3 libftdi-dev \
        qt5-default python3-dev libboost-all-dev cmake

# Node.js for the web server
RUN apt-get update && apt-get install -y nodejs npm

# Install NPM dependencies
WORKDIR /app
COPY ./server/package*.json ./
RUN npm install

# Copy Node.js application source
COPY ./server/app.js .
COPY ./server/synthesis .

# Start Node.js app
CMD ["node", "app.js"]
