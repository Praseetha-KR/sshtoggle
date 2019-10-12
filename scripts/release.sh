#!/bin/bash

cd sshtoggled
rm -rf .theos
rm -rf packages
make package FINALPACKAGE=1
# make install
cd ..

cd sshtoggle
rm -rf .theos
rm -rf packages
make package FINALPACKAGE=1
# make install
cd ..

