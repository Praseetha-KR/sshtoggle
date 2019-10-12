#!/bin/bash
set -eux

cd sshtoggled
make package FINALPACKAGE=1
cd ..

cd sshtoggle
make package install
cd ..

echo "Done!"
