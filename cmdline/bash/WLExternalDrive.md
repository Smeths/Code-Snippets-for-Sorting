# How to - Partition and Format an External Drive for Linux and Windows
## Steps
1. With the external drive unattached Type "sudo blkid | grep UUID" to list the internal drives
2. Attach drive into USB
3. Type "sudo blkid | grep UUID" to list internal and external drives, compare the output to the output from step 1 to find the details of the external drive. Typically something like:


/dev/sda1: LABEL_FATBOOT="distro" LABEL="distro" UUID="65FD-01C1" TYPE="vfat" PARTUUID="882e45ef-01"


4. Unmount the drive by typing "umount /dev/sda1"
5. Load the drive into fdisk by typing "sudo fdisk /dev/sda"
6. Type d to delete the partition; n for a new partition (except the default options); t to change the type of the partition, change the type to 7 (HPFS/NTFS/exFAT); w to write the changes to the disk and q to quit
7. To fast format the drive type sudo mkfs.ntfs -f /dev/sda1

Notes:
1. I found the ext4 file system had complications with read write permissions on a linux machine. I found this when auto mounting, not sure what happens when just "plugging in".
2. As best I can tell the fat file systems have a file size limit, that caused problem. I'm not whether this is the operating systeming limiting the file system or a limit purely of the file system

Useful Links:

[Theory of Files and File Systems](https://www.youtube.com/watch?v=KN8YgJnShPM)

[Difference between file system types](https://www.youtube.com/watch?v=5tBz44cArR0). Some of the tables are useful, though I'm not sure all of the info is correct.




