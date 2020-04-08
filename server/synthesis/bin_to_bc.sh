#!/bin/bash

binfile="$1"
header2="E+Fri_14_Jun_2019_09:00:38_PM_UTC+shastaplus"

# Sorry, everyone... I know this binary is a bit vague.
# We'll open-source the C code soon.
&>/dev/null ./compress-bitstream "$binfile" "$binfile".h h  "$header2"
&>/dev/null ./compress-bitstream "$binfile".h "$binfile".c  c
&>/dev/null ./compress-bitstream "$binfile".c "$binfile".cbin  b
&>/dev/null ./compress-bitstream "$binfile".cbin "$binfile".db db
