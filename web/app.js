#!/usr/bin/env node

// Node.js Standard Library
const os   = require("os");
const fs   = require("fs");
const path = require("path");

// NPM Dependencies
const WebSocket = require("ws");

// Create WebSocket Server
const port = process.env.port || 2019;
const wss  = new WebSocket.Server({port},
  () => console.log("listening on ws://0.0.0.0:"+port));

// Create WebSocket Message Handler
wss.on("connection", ws => {
  ws.on("message", msg => {
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
  });
});

// Synthesis Request
function synthesize(ws, data) {
  console.log("Recieved Synthesis Request...");

  // Generate a temp directory
  console.log("Generating temp directory...");
  const tmpdir = fs.mkdtempSync(path.join(os.tmpdir(), "icestorm-server_"));
  console.log(tmpdir);

  try {
    // Save the files the the temp directory, then synthesize the HDL.
    console.log("Saving source files to temp directory...");
    for (let file of data.files) {
      console.log(file.name);
      fs.writeFileSync(`${tmpdir}/${file.name}`, file.body);
    }

    // Run the IceStorm toolchain flow
    console.log("Running IceStorm flow with Make...");
    run_icestorm_make(tmpdir, data.top_module);
  } catch (e) {
    console.error(e);
    console.error("error: unable to synthesize");
  } finally {
    // Purge temp directory
    /*rmdir(tmpdir);*/
  }
}

function run_icestorm_make(dir, top_module) {
}

// https://stackoverflow.com/a/32197381
function rmdir(path) {
  if (fs.existsSync(path)) {
    fs.readdirSync(path).forEach(function(file, index) {
      var curPath = path + "/" + file;
      if (fs.lstatSync(curPath).isDirectory()) { // recurse
        deleteFolderRecursive(curPath);
      } else { // delete file
        fs.unlinkSync(curPath);
      }
    });
    fs.rmdirSync(path);
  }
}
