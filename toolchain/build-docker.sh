#!/bin/bash

cache=false
ip addr | grep 10.0.10.0/24 && cache=true

version=0.2.0
name="webfpga/icestorm"

docker build --tag $name:$version .
docker tag $name:$version $name:latest
