#!/bin/bash

###############################################################################
# Bash script that downloads and does setup for a Dart SDK.                   #
# Takes three params; first listed is the default:                            #
# $1: Dart channel: stable<@version>|beta<@version>|dev<@version>             #
# $2: OS: Linux|Windows|macOS                                                 #
# $3: ARCH: x64|ia32                                                          #
###############################################################################


# Parse args.
CHANNEL="${1:-stable}"
VERSION=$(echo $CHANNEL | cut -s -d'@' -f 2)
if [[ ! "$VERSION" ]]
then
  VERSION=latest
else
  # A version was specified, but the channel should just be the first part before the version delimiter
  CHANNEL=$(echo $CHANNEL | cut -s -d'@' -f 1)
fi
OS="${3:-Linux}"
ARCH="${4:-x64}"
OS=$(echo "$OS" | awk '{print tolower($0)}')
echo "Installing Dart SDK version \"${VERSION}\" from the ${CHANNEL} channel on ${OS}-${ARCH}"

# Calculate download Url. Based on:
# https://dart.dev/tools/sdk/archive#download-urls
PREFIX="https://storage.googleapis.com/dart-archive/channels"
URL="${PREFIX}/${CHANNEL}/release/${VERSION}/sdk/dartsdk-${OS}-${ARCH}-release.zip"
echo "Downloading ${URL}..."

# Download installation zip.
curl --connect-timeout 15 --retry 5 "$URL" > "${HOME}/dartsdk.zip"
unzip "${HOME}/dartsdk.zip" -d "${RUNNER_TOOL_CACHE}" > /dev/null
if [ $? -ne 0 ]; then
  echo -e "::error::Download failed! Please check passed arguments."
  exit 1
fi
rm "${HOME}/dartsdk.zip"

# Update paths.
echo "${HOME}/.pub-cache/bin" >> $GITHUB_PATH
ls ${HOME}/.pub-cache/bin
echo "${RUNNER_TOOL_CACHE}/dart-sdk/bin" >> $GITHUB_PATH

# Report success, and print version.
echo -e "Successfully installed Dart SDK:"
${RUNNER_TOOL_CACHE}/dart-sdk/bin/dart --version
