#!/usr/bin/env python3

SERVER="ws://localhost:2019"

import sys
import json
import base64

# Usage information
if len(sys.argv) <= 2:
    print(f"Usage: {sys.argv[0]} <top_module_name> <source.v> [pinmap.pcf] [source.v ...]\n")
    print("Send a set of Verilog source files to a remote IceStorm synthesis toolchain flow.")
    print("The resulting bitstream is saved as 'bitstream.bin'\n")
    print(f"Example: {sys.argv[0]} fpga_top blinky.v")
    sys.exit()

# Parse arguments
top_module = sys.argv[1]
files = sys.argv[2:]

# Create WebSocket Connection
from websocket import create_connection
ws = create_connection(SERVER)

# Send Synthesis Request
request = {"type": "request_synthesis"}
ws.send(json.dumps(request))

# Log toolchain stdout/stderr to console
while True:
    res  = ws.recv()
    data = json.loads(res)

    # Bitstream received! Close the WebSocket and break
    if data["type"] == "bitstream":
        ws.close()
        break

    # Uh oh... error. Print the message and quit.
    elif data["type"] == "error":
        print("FATAL ERROR:", data["msg"])
        ws.close()
        sys.exit()

    # Log message... print it.
    elif data["type"] == "log":
        strings = list(data["arguments"].values())
        print(" ".join(strings))

# Save the bitstream
bitstream = base64.b64decode(data["bitstream"])
with open("bitstream.bin", "wb") as file:
    file.write(bitstream)