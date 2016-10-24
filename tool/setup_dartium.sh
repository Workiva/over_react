#!/usr/bin/env bash

set -e

DARTIUM_DIST="dartium-linux-x64-release.zip";
echo "Installing Dartium "
curl "http://storage.googleapis.com/dart-archive/channels/stable/raw/latest/dartium/$DARTIUM_DIST" > $DARTIUM_DIST
unzip -u $DARTIUM_DIST > /dev/null
rm $DARTIUM_DIST
mv dartium-* dartiumdir
export DARTIUM_BIN="$PWD/dartiumdir/chrome"

SELENIUM_JAR="selenium-server.jar";
echo "Installing Selenium"
curl "http://selenium-release.storage.googleapis.com/2.48/selenium-server-standalone-2.48.2.jar" > $SELENIUM_JAR
echo "#!/usr/bin/env bash" | tee -a selenium-server
echo "exec java  -jar $PWD/$SELENIUM_JAR \"$@\"" | tee -a selenium-server
chmod +x selenium-server

CHROMEDRIVER="chromedriver.zip";
echo "Installing Chromedriver"
curl "http://chromedriver.storage.googleapis.com/2.14/chromedriver_linux64.zip" > $CHROMEDRIVER
unzip $CHROMEDRIVER
chmod +x chromedriver
ln -s "$PWD/dartiumdir/chrome" "$PWD/dartium"

export PATH=$PATH":$PWD"
