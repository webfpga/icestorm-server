#!/bin/bash
cd $(git rev-parse --show-toplevel)
git subtree -P toolchain/subtree/icestorm pull https://github.com/cliffordwolf/icestorm master --squash
git subtree -P toolchain/subtree/yosys    pull https://github.com/YosysHQ/yosys         master --squash
git subtree -P toolchain/subtree/nextpnr  pull https://github.com/YosysHQ/nextpnr       master --squash
