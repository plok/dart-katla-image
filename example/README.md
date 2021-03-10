## How to compile

CURRENT_DIR = `pwd`

git submodule update --init --recursive

mkdir ./external/katla/build/
cd ./external/katla/build 

cmake -GNinja -DBUILD_SHARED_LIBS=TRUE ../
ninja

cd $CURRENT_DIR

export LD_LIBRARY_PATH=$CURRENT_DIR/external/katla/build/out:$LD_LIBRARY_PATH

dart run ffigen
