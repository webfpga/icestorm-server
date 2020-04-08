cd ..

for repo in yosys icestorm nextpnr; do
    git subtree -P repositories/$repo pull https://github.com/YosysHQ/$repo master --squash
done
