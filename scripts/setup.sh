#!/bin/bash
set -eux

curl http://nix.howett.net/~dhowett/fauxsu.tar --output $THEOS/bin/fauxsu.tar
tar -xvf $THEOS/bin/fauxsu.tar --directory $THEOS/bin/
rm $THEOS/bin/fauxsu.tar
sudo chmod +x $THEOS/bin/fauxsu
sudo chmod +x $THEOS/bin/libfauxsu.dylib
sudo chown root:wheel $THEOS/bin/fauxsu
sudo chown root:wheel $THEOS/bin/libfauxsu.dylib
