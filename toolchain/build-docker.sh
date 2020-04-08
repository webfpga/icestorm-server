#!/bin/bash

cache=false
ip addr | grep 10.0.10.0/24 && cache=true

version=0.2.2-$(git rev-parse --short HEAD)
name="webfpga/icestorm-base"

docker build --tag $name:$version .
