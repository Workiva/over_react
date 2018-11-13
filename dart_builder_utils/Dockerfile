FROM google/dart:1.24.3

WORKDIR /build/
COPY . /build
RUN timeout 5m pub get && pub run dependency_validator -i coverage,dart_style
ARG BUILD_ARTIFACTS_AUDIT=/build/pubspec.lock
FROM scratch
