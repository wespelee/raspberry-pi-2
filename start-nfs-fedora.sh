#!/bin/sh

sudo systemctl stop rpcbind
sudo systemctl stop nfs-server
sudo systemctl stop nfs-lock 
sudo systemctl stop nfs-idmap

sudo systemctl start rpcbind
sudo systemctl start nfs-server
sudo systemctl start nfs-lock 
sudo systemctl start nfs-idmap

sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl enable nfs-lock 
sudo systemctl enable nfs-idmap
