FROM ubuntu:14.04

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
COPY ./server/package*.json .
RUN npm install
