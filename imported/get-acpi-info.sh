#!/bin/sh
# Author: Lekensteyn <lekensteyn@gmail.com>
# This script is released into public domain, do whatever you want with it
# Version history:
# 2012-01-08: Initial release
# 2012-01-08 21:42 UTC: Update bug reporting URL
err=false
if ! dmidecode -V >/dev/null; then
	echo "Please install dmidecode"
	err=true
fi
if ! acpidump -h >/dev/null; then
	echo "Please install acpidump"
	err=true
fi
if ! sudo -V >/dev/null; then
	sudo() {
		echo "Running command as root: $*"
		su -c "$*"
	}
fi
$err && exit

cd "$(mktemp -d)"

echo "Dumping ACPI tables..."
sudo acpidump > acpidump.txt
acpixtract acpidump.txt
# everything can be retrieved from the dump, iasl is not mandatory
iasl -h >/dev/null && for i in *.dat; do iasl -d "$i"; done
# clear the file

echo "Gathering computer model and BIOS version..."
: > dmidecode.txt
info="system-manufacturer system-product-name system-version"
info="$info baseboard-manufacturer baseboard-product-name baseboard-version"
info="$info bios-vendor bios-version bios-release-date"
for key in $info;do printf "%-22s: %s\n" $key "$(sudo dmidecode -s $key)" >>dmidecode.txt;done

echo "Dumping PCI information..."
lspci -vvvnn > lspci.txt
name="$(head -2 dmidecode.txt | sed 's/ *$//;s/^[^:]*: *//;s/[^A-Za-z0-9.,-]/_/g' | tr '\n' - | sed 's/-$//')"
mkdir -p "$name" && cp *.dsl *.txt "$name"

tar czf "$name.tar.gz" "$name"

echo "Please submit the below file on https://bugs.launchpad.net/lpbugreporter/+bug/752542/+addcomment"
ls -l "$PWD/$name.tar.gz"
