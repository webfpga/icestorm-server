#!/usr/bin/env node

const WebSocket = require("ws");

// Create WebSocket Server
const port = process.env.port || 2019;
const wss  = new WebSocket.Server({port},
  () => console.log("listening on ws://0.0.0.0:"+port));

// Create WebSocket Message Handler
wss.on("connection", ws => {
  ws.on("message", on_msg(ws));
});

function on_msg(ws) {
  return msg => {
    // Parse JSON WebSocket Message
    let data;
    try {
      data = JSON.parse(msg);
      console.log("recv", data);
    } catch (e) {
      console.error("error: unable to parse JSON");
      data = {type: "JSON_Error"};
    }

    // Route Requests
    switch (data.type) {
      case "request_synthesis":
        synthesize(ws, data);
        break;

      default:
        console.error("error: unrecognized data type:", data.type);
        break;
    }

    console.log("----");
  };
}

// Synthesis Request
function synthesize(ws, data) {
  console.log("Recieved Synthesis Request...");
  console.log("Generating temp directory");
}
