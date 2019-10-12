#!/bin/bash
set -eux

cd sshtoggled
make package
cd ..

cd sshtoggle
make package
cd ..

echo "Done!"
