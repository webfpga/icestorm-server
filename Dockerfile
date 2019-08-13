FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
        build-essential clang bison flex libreadline-dev \
        gawk tcl-dev libffi-dev git mercurial graphviz   \
        xdot pkg-config python python3 libftdi-dev \
        qt5-default python3-dev libboost-all-dev cmake
