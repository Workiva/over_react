# Use Dart 2
FROM google/dart:2.3.1

WORKDIR .

# Expose env vars for git ssh access
ARG GIT_SSH_KEY
ARG KNOWN_HOSTS_CONTENT

# Install SSH keys for git ssh access
RUN mkdir /root/.ssh/ && \
  echo "$KNOWN_HOSTS_CONTENT" > "/root/.ssh/known_hosts" && \
  chmod 700 /root/.ssh/ && \
  umask 0077 && echo "$GIT_SSH_KEY" >/root/.ssh/id_rsa && \
  eval "$(ssh-agent -s)" && ssh-add /root/.ssh/id_rsa

WORKDIR /build/
ADD . /build/

RUN cd over_react_analyzer_plugin && pub get && \
    pub run dart_dev analyze

ARG BUILD_ARTIFACTS_BUILD=/build/over_react_analyzer_plugin/pubspec.lock

FROM scratch