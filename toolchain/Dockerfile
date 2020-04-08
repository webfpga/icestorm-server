FROM ubuntu:18.04 AS build
ARG DEBIAN_FRONTEND=noninteractive

# enable apt-cacher
RUN timeout 1 bash -c 'cat >/dev/tcp/192.168.3.2/3142 </dev/null'\
    && sed -e 's/http:\/\//http:\/\/192.168.3.2:3142\//g' -i /etc/apt/sources.list; exit 0
RUN timeout 1 bash -c 'cat >/dev/tcp/10.0.10.62/3142 </dev/null'\
    && sed -e 's/http:\/\//http:\/\/10.0.10.62:3142\//g' -i /etc/apt/sources.list; exit 0

# IceStorm build pre-requiresites
RUN apt-get update && apt-get install -y \
    build-essential clang bison flex libreadline-dev \
    gawk tcl-dev libffi-dev git mercurial graphviz   \
    xdot pkg-config python python3 libftdi-dev \
    qt5-default python3-dev libboost-all-dev cmake libeigen3-dev

# Source repositories...
# Hint: you should update these every once in a while with
# the subtree/pull.sh script
COPY ./subtree /

# IceStorm
WORKDIR /icestorm
RUN make -j$(nproc)
RUN make install

# nextpnr
WORKDIR /nextpnr
RUN cmake -DARCH=ice40 .
RUN make -j$(nproc)
RUN make install

# Yosys
WORKDIR /yosys
RUN make -j$(nproc)

WORKDIR /
RUN rm -rf /icestorm /nextpnr /yosys

CMD ["bash"]
