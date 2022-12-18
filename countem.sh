#!/bin/bash -
#
# Cybersecurity Ops with bash
# countem.sh
#
# Description: 
# 표준입력으로 입력된 항목들의 빈도
#
# Usage:
# countem.sh < inputfile
#

## 연관배열, 해쉬테이블사전 자료구조 bash4.0 지원 -A 연관배열 선언!
declare -A cnt        
while read id xtra                               # <2>
do
    # let 한줄 계산하기 $ 안써도 됨!
    let cnt[$id]++                               # <3>
done
## 연관배열의 모든 키 나열하기 ${!cnt[@]}
for id in "${!cnt[@]}"                           # <4>
do    
	printf '%s %d\n'  "$id"  "${cnt[$id]}"       # <5>
done