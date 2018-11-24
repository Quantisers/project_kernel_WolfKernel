#!/sbin/sh
#
# Rainforce279 - Ryan Andri @ 24102018
# F2FS Patcher.

# Create dir ramdisk
mkdir /tmp/clarity/ramdisk
cd /tmp/clarity/ramdisk
gunzip -c ../boot.img-ramdisk.gz | cpio -i

# Perform backup before replacing fstab.qcom.
if [ ! -f /tmp/clarity/ramdisk/fstab.qcom.backup ];
then
	mv /tmp/clarity/ramdisk/fstab.qcom /tmp/clarity/ramdisk/fstab.qcom.backup
fi

# Perform check before replacing fstab.qcom.
if [ ! -f /tmp/clarity/ramdisk/fstab.qcom ];
then
	cp /tmp/clarity/fstab.qcom /tmp/clarity/ramdisk/fstab.qcom
else
	rm -f /tmp/clarity/ramdisk/fstab.qcom
	cp /tmp/clarity/fstab.qcom /tmp/clarity/ramdisk/fstab.qcom
fi

# Repack ramdisk with zip compression.
find . | cpio -o -H newc | gzip > ../patched-ramdisk.gz

# Back to root dir.
cd /

