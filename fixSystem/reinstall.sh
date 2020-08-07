#!/bin/bash
pkgcount=0
for num in $(cat packages.txt)
do
    pkgcount=$((pkgcount+1))
done

pkgcurr=0
for pkg in $(cat packages.txt)
do
    pkgcurr=$((pkgcurr+1))
    if [[ $pkgcurr -ge 2049 ]]; then
        echo "Installing $pkgcurr/$pkgcount"
        yay -S --noconfirm $pkg --sudoloop
    fi
done

echo "Reinstalled all packages."
