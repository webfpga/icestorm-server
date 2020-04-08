#!/bin/bash
cd $(git rev-parse --show-toplevel)
git subtree -P toolchain/subtree/icestorm add https://github.com/cliffordwolf/icestorm master --squash
git subtree -P toolchain/subtree/yosys    add https://github.com/YosysHQ/yosys         master --squash
git subtree -P toolchain/subtree/nextpnr  add https://github.com/YosysHQ/nextpnr       master --squash
