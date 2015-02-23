help () {
    echo "Usage: $0 [Options]"
    echo ""
    echo "Mandatory arguments to long options:"
    echo -e "\tras\tBuild Official Raspberry PI Kernel."
    echo -e "\tvc4\tBuild VC4 Raspberry PI Kernel."
    echo -e "\tmesa\tBuild MESA library"
    echo -e "\tupdate\tUpdate all repository."
    exit 0
}

ROOT_PATH=`pwd`

export VC4_KERNEL=vc4-kernel
export PI_TOOLS=pi-tools
export RAS_KERNEL=ras-kernel
export MESA=mesa
export INSTALL_PATH=install
export PATH=$ROOT_PATH/$PI_TOOLS/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/:$PATH

if [ "x$1" == "xras" ]; then
    BUILD_KERNEL=1
    KERNEL_PATH=$ROOT_PATH/$RAS_KERNEL
elif [ "x$1" == "xvc4" ]; then
    BUILD_KERNEL=1
    KERNEL_PATH=$ROOT_PATH/$VC4_KERNEL
elif [ "x$1" == "xupdate" ]; then
    echo $1
elif [ "x$1" == "xmesa" ]; then
    BUILD_MESA=1
elif [ "x$1" == "x" ]; then
    help
elif [ "x$1" == "xhelp" ]; then
    help
fi

# Repo
if [ ! -e $ROOT_PATH/$VC4_KERNEL ]; then
    git clone https://github.com/anholt/linux.git $VC4_KERNEL
fi
if [ ! -e $ROOT_PATH/$PI_TOOLS ]; then
    git clone https://github.com/raspberrypi/tools $PI_TOOLS
fi
if [ ! -e $ROOT_PATH/$RAS_KERNEL ]; then
    git clone https://github.com/raspberrypi/linux $RAS_KERNEL
fi
if [ ! -e $ROOT_PATH/$MESA ]; then
    git clone git://anongit.freedesktop.org/mesa/mesa $MESA
fi

mkdir -p $ROOT_PATH/$INSTALL_PATH

if [ $BUILD_MESA -eq 1 ]; then
    cd $MESA
    ./autogen.sh \
        --host=arm-linux- \
        --prefix=$ROOT_PATH/$INSTALL_PATH \
        --with-gallium-drivers=vc4 \
        --enable-gles1 \
        --enable-gles2 \
        --with-egl-platforms=x11,drm
    make
    make install
    cd ..
    exit 0
fi

if [ $BUILD_KERNEL -eq 1 ]; then
    make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig -C $KERNEL_PATH
    make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -C $KERNEL_PATH
    exit 0
fi
