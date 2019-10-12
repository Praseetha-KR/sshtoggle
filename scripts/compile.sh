#!/bin/bash
set -eux

cd sshtoggle-daemon
make package FINALPACKAGE=1
dpkg -x ./packages/*.deb ./packages
mkdir -p ../sshtoggle-tweak/layout/usr/bin
mv ./packages/usr/bin/sshtoggled ../sshtoggle-tweak/layout/usr/bin
# mv ./packages/usr/bin/sshtoggled ../sshtoggle-tweak/layout/usr/bin
cd ..

cd sshtoggle-tweak
make package FINALPACKAGE=1
cp ./packages/*.deb ../
cd ..

rm -r ./sshtoggle-daemon/packages/usr
echo "Done!"
