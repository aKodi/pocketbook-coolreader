#!/bin/sh

mkdir -p pb360
cd pb360
cmake \
	-D CMAKE_TOOLCHAIN_FILE=../tools/toolchain-arm-pocketbook.cmake \
	-D TARGET_TYPE=ARM \
	-D DEVICE_NAME=pb360 \
	-D MAX_IMAGE_SCALE_MUL=2 \
	-D CMAKE_BUILD_TYPE=Release \
	-D ENABLE_CHM=1 \
	-D ENABLE_ANTIWORD=1 \
	-D GUI=CRGUI_PB \
	-D CMAKE_CXX_FLAGS_RELEASE:STRING="-fomit-frame-pointer -O1" \
	..
make

cd ..
if [ -f pb360/cr3gui/cr3-pb.app ]; then
    echo 'Strip binary'
    ../../PBSDK/bin/arm-linux-strip pb360/cr3gui/cr3-pb.app
fi
echo 'Done'

bash updateReleases.sh 360
