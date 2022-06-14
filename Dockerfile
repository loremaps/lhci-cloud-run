FROM node:lts-alpine
RUN apk upgrade --no-cache

RUN wget -q -O - https://github.com/benbjohnson/litestream/releases/download/v0.3.8/litestream-v0.3.8-linux-amd64-static.tar.gz \
    | tar -xzC /usr/local/bin

WORKDIR /usr/src/lhci

# Install dependencies
COPY package.json .
RUN npm install


# Copy Litestream configurations file & startup script.
COPY etc/litestream.yml /etc/litestream.yml
COPY scripts/run.sh /scripts/run.sh
COPY lighthouserc.js .

# Create data directory (although this will likely be mounted too)
RUN mkdir -p /data \
    && chown -R node:node /data

USER node

ENV PORT=8080
EXPOSE $PORT

CMD [ "/bin/sh", "/scripts/run.sh" ]