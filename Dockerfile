#
# Ghost Dockerfile
#
# https://github.com/dockerfile/ghost
#

# Pull base image.
FROM dockerfile/nodejs

RUN npm -g install grunt-cli

# Install Ghost.
RUN \
  git clone https://github.com/mbrock/Ghost.git /ghost
RUN \
  cd /ghost && \
  npm install && \
  grunt init && \
  grunt prod
RUN \
  sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js && \
  useradd ghost --home /ghost

# Add files.
ADD start.bash /ghost-start

# Set environment variables.
ENV NODE_ENV production

# Define mountable directories.
VOLUME ["/data", "/ghost-override"]

# Define working directory.
WORKDIR /ghost

# Define default command.
CMD ["bash", "/ghost-start"]

# Expose ports.
EXPOSE 2368
