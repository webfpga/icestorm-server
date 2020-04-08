#!/bin/bash

cache=false
ip addr | grep 10.0.10.0/24 && cache=true

version=0.2.1
name="webfpga/icestorm-base"

docker build --tag $name:$version .
docker tag $name:$version $name:latest
