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
export DRM=drm
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
export LD_LIBRARY_PATH=$INSTALL_PATH/lib:$BIN_PATH/lib/
export PKG_CONFIG_PATH=$INSTALL_PATH/lib/pkgconfig/:$INSTALL_PATH/share/pkgconfig/:$BIN_PATH/lib/pkgconfig/
export PATH=$ROOT_PATH/$PI_TOOLS/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/:$PATH
export ACLOCAL_PATH=$INSTALL_PATH/share/aclocal
export ACLOCAL="aclocal -I $ACLOCAL_PATH"
export HOST_PREFIX="arm-linux-gnueabihf"
#export C_INCLUDE_PATH=$BIN_PATH/include

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
if [ ! -e $ROOT_PATH/$DRM ]; then
    git clone git://anongit.freedesktop.org/git/mesa/drm $DRM
fi
if [ ! -e $ROOT_PATH/$GLPROTO ]; then
    git clone git://anongit.freedesktop.org/xorg/proto/glproto $GLPROTO
fi
if [ ! -e $ROOT_PATH/$DRI2PROTO ]; then
    git clone git://anongit.freedesktop.org/xorg/proto/dri2proto $DRI2PROTO
fi
if [ ! -e $ROOT_PATH/$DRI3PROTO ]; then
    git clone git://anongit.freedesktop.org/xorg/proto/dri3proto $DRI3PROTO
fi
if [ ! -e $ROOT_PATH/$PRESENTPROTO ]; then
    git clone git://anongit.freedesktop.org/xorg/proto/presentproto $PRESENTPROTO
fi
if [ ! -e $ROOT_PATH/$XCBPROTO ]; then
    git clone git://anongit.freedesktop.org/xcb/proto $XCBPROTO
fi
if [ ! -e $ROOT_PATH/$MACROS ]; then
    git clone git://anongit.freedesktop.org/xorg/util/macros $MACROS
fi
if [ ! -e $ROOT_PATH/$LIBXCB ]; then
    git clone git://anongit.freedesktop.org/xcb/libxcb $LIBXCB
fi
if [ ! -e $ROOT_PATH/$LIBXSHMFENCE ]; then
    git clone git://anongit.freedesktop.org/xorg/lib/libxshmfence $LIBXSHMFENCE
fi
if [ ! -e $ROOT_PATH/$PTHREADSTUBS ]; then
    git clone git://anongit.freedesktop.org/xcb/pthread-stubs $PTHREADSTUBS
fi
if [ ! -e $ROOT_PATH/$XAU ]; then
    git clone git://anongit.freedesktop.org/xorg/lib/libXau $XAU
fi
if [ ! -e $ROOT_PATH/$XPROTO ]; then
    git clone git://anongit.freedesktop.org/xorg/proto/xproto $XPROTO
fi
if [ ! -e $ROOT_PATH/$XEXTPROTO ]; then
    git clone git://anongit.freedesktop.org/xorg/proto/xextproto $XEXTPROTO
fi

mkdir -p $INSTALL_PATH
mkdir -p $ACLOCAL_PATH

if [ $BUILD_MESA -eq 1 ]; then
    #echo "####### Build $PTHREADSTUBS #######"
    #cd $PTHREADSTUBS
    #./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
    #make clean && make && make install
    #cd ..

    #echo "####### Build $XAU #######"
    #cd $XAU
    #./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
    #make clean && make && make install
    #cd ..

#    echo "####### Build $DRM #######"
#    cd $DRM
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $GLPROTO #######"
#    cd $GLPROTO
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $DRI2PROTO #######"
#    cd $DRI2PROTO 
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $DRI3PROTO #######"
#    cd $DRI3PROTO 
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $PRESENTPROTO #######"
#    cd $PRESENTPROTO
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $XCBPROTO #######"
#    # needed by libxcb:
#    cd $XCBPROTO
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $MACROS #######"
#    # needed by libxcb:
#    cd $MACROS
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $LIBXCB #######"
#    cd $LIBXCB
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $LIBXSHMFENCE #######"
#    cd $LIBXSHMFENCE
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $XPROTO #######"
#    cd $XPROTO
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
#    echo "####### Build $XEXTPROTO #######"
#    cd $XEXTPROTO
#    ./autogen.sh --prefix=$INSTALL_PATH --host=$HOST_PREFIX
#    make clean && make && make install
#    cd ..
#
    echo "####### Build $MESA #######"
    cd $MESA
    ./autogen.sh \
#    ./configure \
        --host=$HOST_PREFIX \
        --prefix=$INSTALL_PATH \
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
