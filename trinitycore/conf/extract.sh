#!/bin/bash

BINDIR=/home/wow/server/bin
GAMEDIR=/tmp/game

#rm -rf $BINDIR/Cmaeras/*:
rm -rf $BINDIR/dbc/*:
rm -rf $BINDIR/maps/*:
rm -rf $BINDIR/mmaps/*:
rm -rf $BINDIR/vmaps/*:

cp $BINDIR/mapextractor $GAMEDIR;
cp $BINDIR/vmap4extractor $GAMEDIR;
cp $BINDIR/vmap4assembler $GAMEDIR;

cd $GAMEDIR;
./mapextractor;
./vmap4extractor;
mkdir vmaps;
./vmap4assembler Buildings vmaps;
rm -rf Buildings;
#mv Cameras/* $BINDIR/Cameras/;
mv dbc/* $BINDIR/dbc/;
mv maps/* $BINDIR/maps/;
mv vmaps/* $BINDIR/vmaps/;
rm -rf dbc;
rm -rf maps;
rm -rf vmaps;
rm mapextractor;
rm vmap4extractor;
rm vmap4assembler;

cd $BINDIR;
./mmaps_generator;