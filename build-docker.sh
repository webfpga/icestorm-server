#!/bin/bash

version=0.0.2
docker build -t webfpga/icestorm-server:$version .
docker tag webfpga/icestorm-server:$version webfpga/icestorm-server:latest
