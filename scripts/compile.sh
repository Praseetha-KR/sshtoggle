#!/bin/bash
set -eux

cd sshtoggle
make package
cd ..

echo "Done!"
