#!/bin/bash
set -eux

cd sshtogd
make package FINALPACKAGE=1
rm -rf tmp/
mkdir tmp
dpkg-deb -R ./packages/in.imagineer.sshtogd_0.0.1_iphoneos-arm.deb ./tmp
ldid -Sent.xml ./tmp/usr/bin/sshtogd
dpkg-deb -b ./tmp ./packages/in.imagineer.sshtogd_0.0.1_iphoneos-arm.deb
make install
cd ..

cd sshtoggle-daemon
make package FINALPACKAGE=1
dpkg -x ./packages/*.deb ./packages
mkdir -p ../sshtoggle-tweak/layout/usr/bin
mv ./packages/usr/bin/sshtoggled ../sshtoggle-tweak/layout/usr/bin
# mv ./packages/usr/bin/sshtoggled ../sshtoggle-tweak/layout/usr/bin
cd ..

cd sshtoggle-tweak
make package install
cp ./packages/*.deb ../
cd ..

rm -r ./sshtoggle-daemon/packages/usr
echo "Done!"
