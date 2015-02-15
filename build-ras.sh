ROOT_PATH=`pwd`

export VC4_KERNEL=vc4-kernel
export PI_TOOLS=pi-tools
export RAS_KERNEL=ras-kernel

if [ ! -e $ROOT_PATH/$VC4_KERNEL ]; then
    git clone https://github.com/anholt/linux.git $VC4_KERNEL
fi
if [ ! -e $ROOT_PATH/$PI_TOOLS ]; then
    git clone https://github.com/raspberrypi/tools $PI_TOOLS
fi
if [ ! -e $ROOT_PATH/$RAS_KERNEL ]; then
    git clone https://github.com/raspberrypi/linux $RAS_KERNEL
fi

export PATH=$ROOT_PATH/$PI_TOOLS/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/:$PATH

cd $RAS_KERNEL
make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig
make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
