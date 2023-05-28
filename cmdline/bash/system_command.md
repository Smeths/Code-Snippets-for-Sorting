# Version Info
lsb_release -a
# Sytem info
lsusb 
lscpu
lsmod
lsblk
df -h
du
## What has happened to the system
sudo dmesg
## Creating an iso on pen drive
sudo umount /dev/sda1
dd if=name.iso of=/dev/sda bs=1M status=progres
