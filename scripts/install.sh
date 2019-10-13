#!/bin/bash
set -eux

cd sshtoggle
make package install
cd ..

echo "Done!"
