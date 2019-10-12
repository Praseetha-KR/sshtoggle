#!/bin/bash
set -eux

cd sshtoggled
make package FINALPACKAGE=1
rm -rf tmp/
mkdir tmp
dpkg-deb -R ./packages/in.imagineer.sshtoggled_0.0.1_iphoneos-arm.deb ./tmp
ldid -Sent.xml ./tmp/usr/bin/sshtoggled
dpkg-deb -b ./tmp ./packages/in.imagineer.sshtoggled_0.0.1_iphoneos-arm.deb
make install
rm -rf tmp
cd ..

cd sshtoggle
make package install
cd ..

echo "Done!"
