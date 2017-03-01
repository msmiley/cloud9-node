FROM msmiley/cloud9

#############################
# Node.js
ENV NODE_VERSION 6.7.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
        && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
        && rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
        && npm install -g coffee-script node-gyp jasmine-node bower codo \
        && npm cache clear

# allow bower to run as root inside container
RUN echo '{ "allow_root": true }' > /root/.bowerrc

# start cloud9 with no authentication by default
# if authentication is desired, set the value of -a, i.e. -a user:pass at docker run
ENTRYPOINT ["node", "c9sdk/server.js", "-w", "/home", "--listen", "0.0.0.0", "-p", "8080"]
CMD ["-a", ":"]