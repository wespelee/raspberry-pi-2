# raspberry-pi-2

1. sudo yum install nfs-utils nfs-utils-lib
2. vi /etc/exports
/work/raspberry/rpi-bin-lib 192.168.1.0/24(rw,no_root_squash)
3. Run start-nfs-fedora.sh

On pi:
1. rsync -avP /usr/ /work/raspberry/rpi-bin-lib
