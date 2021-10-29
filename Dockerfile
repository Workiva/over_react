FROM google/dart:2.13

# Expose env vars for git ssh access
ARG GIT_SSH_KEY
ARG KNOWN_HOSTS_CONTENT
# Install SSH keys for git ssh access
RUN mkdir /root/.ssh
RUN echo "$KNOWN_HOSTS_CONTENT" > "/root/.ssh/known_hosts"
RUN echo "$GIT_SSH_KEY" > "/root/.ssh/id_rsa"
RUN chmod 700 /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa
RUN echo "Setting up ssh-agent for git-based dependencies"
RUN eval "$(ssh-agent -s)" && \
	ssh-add /root/.ssh/id_rsa

WORKDIR /build/
ADD pubspec.yaml /build
RUN pub get
ARG BUILD_ARTIFACTS_AUDIT=/build/pubspec.lock
FROM scratch
