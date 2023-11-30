#!/bin/bash
Xvfb :99 -screen 0 1366x768x16 -nolisten tcp -fbdir /var/run > /dev/null 2>&1 &
export DISPLAY=:99
git clone https://github.com/muuklabs/executor.git
cd executor || { echo "Failure: executor directory not found!"; exit 1; }
git checkout videoEnabled
"$MUUKTEST_KEY" > key.pub
cat key.pub
chmod 755 gradlew
chmod 755 key.pub
sed -i 's/79.0.3945.36/86.0.4240.22/g' build.gradle
cat build.gradle