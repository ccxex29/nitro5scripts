#!/bin/bash

if [ -d "/run/media/ccxex29/8207371b-52ca-4032-822a-cd9164c52190" ]; then
	pkexec umount /run/media/ccxex29/8207371b-52ca-4032-822a-cd9164c52190
	pkexec rm -R /run/media/ccxex29/8207371b-52ca-4032-822a-cd9164c52190
else
	pkexec mkdir /run/media/ccxex29/8207371b-52ca-4032-822a-cd9164c52190
	pkexec apfs-fuse /dev/sda2 /run/media/ccxex29/8207371b-52ca-4032-822a-cd9164c52190
fi