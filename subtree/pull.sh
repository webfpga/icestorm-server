#!/bin/bash
cd ..
git subtree -P subtree/icestorm pull https://github.com/cliffordwolf/icestorm master --squash
git subtree -P subtree/yosys    pull https://github.com/YosysHQ/yosys         master --squash
git subtree -P subtree/nextpnr  pull https://github.com/YosysHQ/nextpnr       master --squash
