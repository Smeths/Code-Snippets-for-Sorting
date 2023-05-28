for filename in *.h264; do
    dvr-scan -d "/media/linuxlite/58440497163AEEB1/Videos/Back Fence Break 012023/25th/motion" -t 0.7 -fs 100 -i "${filename}"
    echo ${filename} >> complete.txt
done
