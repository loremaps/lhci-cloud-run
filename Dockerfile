FROM node:lts-alpine
RUN apk upgrade --no-cache

# Download the static build of Litestream directly into the path & make it executable.
# This is done in the builder and copied as the chmod doubles the size.
ADD https://github.com/benbjohnson/litestream/releases/download/v0.3.8/litestream-v0.3.8-linux-amd64-static.tar.gz /tmp/litestream.tar.gz
RUN tar -C /usr/local/bin -xzf /tmp/litestream.tar.gz

WORKDIR /usr/src/lhci

COPY package.json .
COPY lighthouserc.json .
RUN npm install

# Copy Litestream configuration file & startup script.
COPY etc/litestream.yml /etc/litestream.yml
COPY scripts/run.sh /scripts/run.sh

# Create data directory (although this will likely be mounted too)
RUN mkdir -p /data
RUN chown node:node /data

USER node

# Notify Docker that the container wants to expose a port.
EXPOSE 8080

CMD [ "/bin/sh", "/scripts/run.sh" ]