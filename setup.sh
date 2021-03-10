#!/usr/bin/env bash

CURRENT_DIR = `pwd`

mkdir ./external/katla/build/
cd ./external/katla/build 

cmake -GNinja -DBUILD_SHARED_LIBS=TRUE ../
ninja

cd $CURRENT_DIR

export LD_LIBRARY_PATH=./external/katla/build/out:$LD_LIBRARY_PATH

dart run ffigen
