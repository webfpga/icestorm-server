#!/bin/bash

cache=false
ip addr | grep 10.0.10.0/24 && cache=true

#for base in ubuntu:18.04 ubuntu:20.04; do
for base in ubuntu:20.04; do
    version=0.1.0-$(tr ':' '-' <<< $base)
    docker build\
        --build-arg BASE_IMAGE=$base\
        --build-arg USE_CACHE=$cache\
        --tag webfpga/icestorm-server:$version .
    #docker tag webfpga/icestorm-server:$version webfpga/icestorm-server:latest
done
