#!/bin/sh
rm -f dial-a-pirate.love
zip -r dial-a-pirate.love ./ --exclude \*.zip --exclude .\* --exclude \*.sh
