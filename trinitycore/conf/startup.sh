#!/bin/bash

BINDIR=/home/wow/server/bin

sed -i "s/##REPLACE##/##CHANGE##/g" /home/wow/server/etc/*.conf;

rm $BINDIR/world.input;
touch $BINDIR/world.input;
$BINDIR/worldserver < $BINDIR/world.input &
while ! nc -q 1 localhost 8085 </dev/null; do sleep 1; done
$BINDIR/bnetserver &
bash;