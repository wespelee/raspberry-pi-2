#!/bin/sh

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

#export VC4_KERNEL=fix-kernel
export VC4_KERNEL=vc4-kernel
export PI_TOOLS=pi-tools
export RAS_KERNEL=ras-kernel
export MESA=mesa
export DRM=drm
export XPROTO=xproto
export RANDRPROTO=randrproto
export XFONT=libXfont
export XSERVER=xserver
export XF86_INPUT_EVDEV=xf86-input-evdev

export GLPROTO=glproto
export DRI2PROTO=dri2proto
export DRI3PROTO=dri3proto
export PRESENTPROTO=presentproto
export XCBPROTO=xcbproto
export MACROS=macros
export LIBXCB=libxcb
export LIBXSHMFENCE=libxshmfence
export PTHREADSTUBS=pthread-stubs
export XAU=xau
export XPROTO=xproto
export XEXTPROTO=xextproto

export INSTALL_PATH=$ROOT_PATH/install
export BIN_PATH=$ROOT_PATH/rpi-bin-lib
# LD_LIBRARY_PATH is for runtime link.
export LD_LIBRARY_PATH=$INSTALL_PATH/lib:$BIN_PATH/lib:$BIN_PATH/lib/arm-linux-gnueabihf:$BIN_PATH/usr/lib/arm-linux-gnueabihf
export LIBRARY_PATH=$INSTALL_PATH/lib:$BIN_PATH/lib:$BIN_PATH/lib/arm-linux-gnueabihf:$BIN_PATH/usr/lib/arm-linux-gnueabihf
export LDFLAGS="-L$BIN_PATH/lib -L$BIN_PATH/lib/arm-linux-gnueabihf -L$BIN_PATH/usr/lib/arm-linux-gnueabihf"
export PKG_CONFIG_PATH=$INSTALL_PATH/lib/pkgconfig:$INSTALL_PATH/share/pkgconfig:$BIN_PATH/usr/lib/arm-linux-gnueabihf/pkgconfig:$BIN_PATH/usr/share/pkgconfig
export PATH=$ROOT_PATH/$PI_TOOLS/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:$PATH
export ACLOCAL_PATH=$INSTALL_PATH/share/aclocal:$BIN_PATH/usr/share/aclocal
export ACLOCAL="aclocal -I $ACLOCAL_PATH"
export HOST_PREFIX="arm-linux-gnueabihf"

BUILD_KERNEL=0
BUILD_MESA=0
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
    export C_INCLUDE_PATH=$BIN_PATH/usr/include:$BIN_PATH/usr/include/arm-linux-gnueabihf
elif [ "x$1" == "x" ]; then
    help
elif [ "x$1" == "xhelp" ]; then
    help
fi

# Repo
if [ ! -e $ROOT_PATH/$VC4_KERNEL ]; then
    git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git $VC4_KERNEL
    cd $VC4_KERNEL
    git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
    git fetch linux-next
    git checkout next-`date +%Y%m%d`
    cd ..
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
if [ ! -e $ROOT_PATH/$DRM ]; then
    git clone git://anongit.freedesktop.org/git/mesa/drm $DRM
fi
if [ ! -e $ROOT_PATH/$XPROTO ]; then
    git clone git://anongit.freedesktop.org/xorg/proto/xproto $XPROTO
fi
if [ ! -e $ROOT_PATH/$RANDRPROTO ]; then
    git clone git://anongit.freedesktop.org/xorg/proto/randrproto $RANDRPROTO
fi
if [ ! -e $ROOT_PATH/$XFONT ]; then
    git clone git://git.freedesktop.org/git/xorg/lib/libXfont $XFONT
fi
if [ ! -e $ROOT_PATH/$XSERVER ]; then
    git clone git://git.freedesktop.org/git/xorg/xserver $XSERVER
fi
if [ ! -e $ROOT_PATH/$XF86_INPUT_EVDEV ]; then
    git clone git://git.freedesktop.org/git/xorg/driver/xf86-input-evdev $XF86_INPUT_EVDEV
fi

mkdir -p $INSTALL_PATH
mkdir -p $ACLOCAL_PATH

# Modify binary pkgconfig files to current path
for fn in `ls $BIN_PATH/usr/lib/arm-linux-gnueabihf/pkgconfig`
do
    sed -i "s@^prefix=.*@prefix=$BIN_PATH/usr@g" $BIN_PATH/usr/lib/arm-linux-gnueabihf/pkgconfig/$fn
done

for fn in `ls $BIN_PATH/usr/share/pkgconfig`
do
    sed -i "s@^prefix=.*@prefix=$BIN_PATH/usr@g" $BIN_PATH/usr/share/pkgconfig/$fn
done

if [ $BUILD_MESA -eq 1 ]; then

    #echo "####### Build $DRM #######"
    #cd $DRM
    #./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
    #make clean && make && make install
    #cd ..

    #echo "####### Build $MESA #######"
    #cd $MESA
    #./autogen.sh --host=$HOST_PREFIX --prefix=$INSTALL_PATH \
    #    --with-gallium-drivers=vc4 \
    #    --with-dri-drivers= \
    #    --with-egl-platforms=x11,drm
    #make
    #make install
    #cd ..

    echo "####### Build $XSERVER #######"
    #cd $XPROTO
    #./autogen.sh --host=$HOST_PREFIX --prefix=$INSTALL_PATH
    #make
    #make install
    #cd ..

    #cd $RANDRPROTO
    #./autogen.sh --host=$HOST_PREFIX --prefix=$INSTALL_PATH
    #make
    #make install
    #cd ..

    cd $XFONT
    #./autogen.sh --host=$HOST_PREFIX --prefix=$INSTALL_PATH
    #make
    #make install
    cd ..

    cd $XSERVER
    ./autogen.sh --host=$HOST_PREFIX --prefix=$INSTALL_PATH \
        --with-log-dir=/var/log \
        --enable-install-setuid
    make
    make install
    cd ..

    #cd $XF86_INPUT_EVDEV
    #./autogen.sh --host=$HOST_PREFIX --prefix=$INSTALL_PATH
    #make
    #make install
    #cd ..

    exit 0
fi

if [ $BUILD_KERNEL -eq 1 ]; then
    echo "Build Kernel: $KERNEL_PATH"
    cd $KERNEL_PATH
    make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- multi_v7_defconfig 
    make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
    make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules
    make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf modules_install INSTALL_MOD_PATH=$INSTALL_PATH
    #make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- oldconfig
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- dtbs
    cp arch/arm/boot/dts/bcm2836-rpi-2-b.dtb $INSTALL_PATH
    cp arch/arm/boot/zImage $INSTALL_PATH/kernel-vc4.img
    tar zcvf $INSTALL_PATH/modules.tgz $INSTALL_PATH/lib/modules
    exit 0
fi
