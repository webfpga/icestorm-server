#!/usr/bin/env python3

SERVER="ws://localhost:2019"

import sys
import json
import base64

if len(sys.argv) != 2:
    print(f"Usage: {sys.argv[0]} <top_module_name> <source.v> [pinmap.pcf] [source.v ...]\n")
    print("Send a set of Verilog source files to a remote IceStorm synthesis toolchain flow.")
    print("The resulting bitstream is saved as 'bitstream.bin'\n")
    print(f"Example: {sys.argv[0]} fpga_top blinky.v")
    sys.exit()

# Create WebSocket Connection
from websocket import create_connection
ws = create_connection(SERVER)

# Send Synthesis Request
request = {"type": "request_synthesis"}
ws.send(request)

# Log toolchain stdout/stderr to console
while True:
    res  = ws.recv()
    data = json.loads(res)

    if data["type"] == "bitstream":
        break
    elif data["type"] == "log":
        strings = list(data["arguments"].values())
        print(" ".join(strings))

# Close WebSocket and save the bitstream
ws.close()
bitstream = base64.b64decode(data["bitstream"])
with open("bitstream.bin", "wb") as file:
    file.write(bitstream)
