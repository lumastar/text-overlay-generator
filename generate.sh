#!/bin/bash

echo "Running for" $1 $2

FONTSIZE=35
ffmpeg -f lavfi -i color=c=#000000@0:s=1920x1080,format=rgba -vf \
"drawtext=text=$1:fontcolor=white:fontsize=$FONTSIZE:x=(w-text_w)/2-744:y=(h-text_h)/2-468-$FONTSIZE/2-5:, \
drawtext=text=$1:fontcolor=white:fontsize=$FONTSIZE:x=(w-text_w)/2-312:y=(h-text_h)/2-468-$FONTSIZE/2-5:, \
drawtext=text=$1:fontcolor=white:fontsize=$FONTSIZE:x=(w-text_w)/2+156:y=(h-text_h)/2-468-$FONTSIZE/2-5:, \
drawtext=text=$1:fontcolor=white:fontsize=$FONTSIZE:x=(w-text_w)/2+660:y=(h-text_h)/2-468-$FONTSIZE/2-5:, \
drawtext=text=$2:fontcolor=white:fontsize=$FONTSIZE:x=(w-text_w)/2-744:y=(h-text_h)/2-468+$FONTSIZE/2+5:, \
drawtext=text=$2:fontcolor=white:fontsize=$FONTSIZE:x=(w-text_w)/2-312:y=(h-text_h)/2-468+$FONTSIZE/2+5:, \
drawtext=text=$2:fontcolor=white:fontsize=$FONTSIZE:x=(w-text_w)/2+156:y=(h-text_h)/2-468+$FONTSIZE/2+5:, \
drawtext=text=$2:fontcolor=white:fontsize=$FONTSIZE:x=(w-text_w)/2+660:y=(h-text_h)/2-468+$FONTSIZE/2+5:" public/output.png -y