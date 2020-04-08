FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

# enable apt-cacher
RUN bash -c 'cat >/dev/tcp/10.0.10.62/3142 </dev/null'\
    && sed -e 's/http:\/\//http:\/\/10.0.10.62:3142\//g' -i /etc/apt/sources.list

# IceStorm prerequiresites
RUN apt-get update && apt-get install -y \
        build-essential clang bison flex libreadline-dev \
        gawk tcl-dev libffi-dev git mercurial graphviz   \
        xdot pkg-config python2.7 python3 libftdi-dev \
        qt5-default python3-dev libboost-all-dev cmake libeigen3-dev

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

CMD ["bash"]
