#!/bin/bash

cache=false
ip addr | grep 10.0.10.0/24 && cache=true

version=0.2.1
docker build --tag webfpga/icestorm-server:$version .
docker tag webfpga/icestorm-server:$version webfpga/icestorm-server:latest
