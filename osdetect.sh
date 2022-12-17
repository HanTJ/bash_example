#!/bin/bash
# MS-Windows/Linux/macOS 구분
# 특정 OS에만 유틸을 이용하여 판별

if type -t wevtutil &> /dev/null
then
	OS=MSWin
elif
	type -t scutil &> /dev/null
then
	OS=macOS
else
	OS=Linux
fi
echo $OS
