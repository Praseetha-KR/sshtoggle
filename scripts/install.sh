#!/bin/bash
set -eux

cd sshtoggled
make package install
cd ..

cd sshtoggle
make package install
cd ..

echo "Done!"
