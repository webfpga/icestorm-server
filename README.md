# icestorm-server

This is a fully open-source and self-hosted implementation of the WebFPGA
interface and synthesis flow. The FPGA bitstream is generated on a
remote server and returned to the client.

For more information about WebFPGA, check out https://webfpga.io.

---

### Command-line Client
The command-line client is written in Python and transmits Verilog source
files and an optional `pinmap.pcf` file to the backend. The backend
responds with real-time logs and the final, compressed bitstream.

By default, it is configured to send jobs to `ws://icestorm.webfpga.io:2019`.
You can change that by modifying the `SERVER=` string in `synthesis.py`.
```console
$ cd client
$ pip install websocket-client
$ ./synthesis.py fpga_top blinky.v pinmap.pcf
$ webfpga flash bitstream.bin
```

### Server
The server is written in Node.js and is a WebSocket wrapper around
a Makefile that runs the IceStorm flow.

To get started, make sure you have IceStorm installed. (This includes
`yosys`, etc...)
```console
$ cd server
$ npm install
$ node app.js
```

### Docker
Or... you can host `icestorm-server` via Docker. This is by far the easiest method to
up and running. For example, if you are running MacOS, all you need is Python
and Docker to get started with the WebFPGA Standalone Board. (That is, if you
want to go the fully open-source and self-hosted route. Remember, you can
always navigate to the official Web IDE (https://beta.webfpga.io) to get
started without any install or software dependencies.)

```console
$ docker run -it --rm -p 2019:2019 webfpga/icestorm-server:latest
```
