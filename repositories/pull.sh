#!/bin/bash
cd ..
git subtree -P repositories/icestorm pull https://github.com/cliffordwolf/icestorm master --squash
git subtree -P repositories/yosys    pull https://github.com/YosysHQ/yosys         master --squash
git subtree -P repositories/nextpnr  pull https://github.com/YosysHQ/nextpnr       master --squash
