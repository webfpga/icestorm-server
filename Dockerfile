FROM webfpga/icestorm-base:0.2.2-410bcecbb
ARG DEBIAN_FRONTEND=noninteractive

# enable apt-cacher
RUN timeout 1 bash -c 'cat >/dev/tcp/10.0.10.62/3142 </dev/null'\
    && sed -e 's/http:\/\//http:\/\/10.0.10.62:3142\//g' -i /etc/apt/sources.list; exit 0

# Node.js for the web server
RUN apt-get update && apt-get install -y nodejs npm

# Install NPM dependencies
WORKDIR /app
COPY ./server/package*.json ./
RUN npm install

# Copy Node.js application source
COPY ./server/app.js .
COPY ./server/synthesis/ ./synthesis

# Start Node.js app
CMD ["node", "app.js"]
