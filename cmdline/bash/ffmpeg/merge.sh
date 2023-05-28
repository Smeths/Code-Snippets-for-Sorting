ls *.avi > list.txt
cat list.txt | sed 's/^/file '\''/' | sed 's/$/'\''/' > new_list.txt
ffmpeg -f concat -safe 0 -i new_list.txt -c copy output.avi
