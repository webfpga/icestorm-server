#!/usr/bin/env python3

SERVER="ws://localhost:2019"

import json
import base64

# Create WebSocket Connection
from websocket import create_connection
ws = create_connection(SERVER)

# Send Synthesis Request
example = '{"type": "request_synthesis", "files": [{"name": "uh.v", "body": "module top(output wire led, input wire button); assign led = button; endmodule"}, {"name": "pinmap.pcf", "body": "set_io led 31\\n set_io button 42"}], "top_module": "top"}'
ws.send(example)

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
