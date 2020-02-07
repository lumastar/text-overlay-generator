#!/bin/bash

echo "Running for" $1

ffmpeg -f lavfi -i color=c=black@0:s=1920x1080,format=rgba -vf "drawtext=text=$1:fontcolor=white:fontsize=50:x=(w-text_w)/2-744:y=(h-text_h)/2-468, drawtext=text=$1:fontcolor=white:fontsize=50:x=(w-text_w)/2-312:y=(h-text_h)/2-468:,drawtext=text=$1:fontcolor=white:fontsize=50:x=(w-text_w)/2+192:y=(h-text_h)/2-468:,drawtext=text=$1:fontcolor=white:fontsize=50:x=(w-text_w)/2+696:y=(h-text_h)/2-468:" public/output.png -y