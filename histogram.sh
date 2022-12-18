#!/bin/bash -
#
# Cybersecurity Ops with bash
# histogram.sh
#
# Description: 
# Generate a horizontal bar chart of specified data
#
# Usage: ./histogram.sh
#   input format: label value
#

#막대 하나 그리는 함수
function pr_bar ()                            # <1>
{
    # 지역변수 -i : 정수 형식
    local -i i raw maxraw scaled              # <2>
    raw=$1
    maxraw=$2

    # 이중괄호안에서 계산식을 넣으면 $ 안써도 됨
    ((scaled=(MAXBAR*raw)/maxraw))            # <3>
    # min size guarantee
    ((raw > 0 && scaled == 0)) && scaled=1				# <4>

    for((i=0; i<scaled; i++)) ; do printf '#' ; done
    printf '\n'
    
} # pr_bar

#
# "main"
#
declare -A RA						# <5>
declare -i MAXBAR max
max=0
MAXBAR=50	# how large the largest bar should be

while read labl val
do
    let RA[$labl]=$val					# <6>
    # keep the largest value; for scaling
    (( val > max )) && max=$val
done

# scale and print it
for labl in "${!RA[@]}"					# <7>
do
    printf '%-20.20s  ' "$labl"
    pr_bar ${RA[$labl]} $max				# <8>
done