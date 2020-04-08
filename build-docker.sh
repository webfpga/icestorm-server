#!/bin/bash

cache=false
ip addr | grep 10.0.10.0/24 && cache=true

#for base in ubuntu:18.04 ubuntu:20.04; do
version=0.0.5-$(tr ':' '-' <<< $base)
docker build --tag webfpga/icestorm-server:$version .
#docker tag webfpga/icestorm-server:$version webfpga/icestorm-server:latest
