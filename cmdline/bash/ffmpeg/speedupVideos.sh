#!/bin/bash
# with a bash for loop
ffmpeg -f concat -safe 0 -i <(for f in ./*.avi; do echo "file '$PWD/$f'"; done) -c copy merge.avi

