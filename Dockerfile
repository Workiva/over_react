FROM google/dart:2.1.0

ADD pubspec.yaml /build
RUN pub get
ARG BUILD_ARTIFACTS_AUDIT=/build/pubspec.lock
FROM scratch
