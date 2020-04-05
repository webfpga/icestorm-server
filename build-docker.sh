#!/bin/bash

#for base in ubuntu:18.04 ubuntu:20.04; do
for base in ubuntu:18.04; do
    version=0.0.3-$(tr ':' '-' <<< $base)
    docker build --build-arg BASE_IMAGE=$base --tag webfpga/icestorm-server:$version .
    docker tag webfpga/icestorm-server:$version webfpga/icestorm-server:latest
done
