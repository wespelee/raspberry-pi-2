# raspberry-pi-2

NFS:
1. sudo yum install nfs-utils nfs-utils-lib
2. vi /etc/exports
/work/raspberry/rpi-bin-lib 192.168.1.0/24(rw,no_root_squash)
3. Run start-nfs-fedora.sh

On pi:
1. rsync -avP /usr/ /work/raspberry/rpi-bin-lib

To build mesa, you need to patch configure file to avoid error like "undefined reference to `__glibc_unlikely`"
1. Add #include <arm-linux-gnueabihf/sys/cdefs.h> before every #include <pthread.h> in configure.

Minor:
1. Add logo.nologo to /boot/cmdline.txt

