#!/bin/bash -
#
# Cybersecurity Ops with bash
# summer.sh
#
# Description: 
# 각각의 고유한 필드1에 대해 필드2의 값들을 합산
#
# Usage: ./summer.sh
#   input format: <name> <number>
#

declare -A cnt        # assoc. array
while read id count
do
  let cnt[$id]+=$count
done
for id in "${!cnt[@]}"
do
    printf "%-15s %8d\n"  "${id}"  "${cnt[${id}]}" #<1>
done