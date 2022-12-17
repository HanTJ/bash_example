#!/bin/bash
# 시스템정보 수집 및 기록
# 출처 : bash를 활용한 사이버 보안 운영

# SepCmds 입력파일 한행 명령 추출
function SepCmds()
{
	LCMD=${ALINE%%|*}
	REST=${ALINE#*|}
	WCMD=${REST%%|*}
	REST=${REST#*|}
	TAG=${REST%%|*}

	if [[ $OSTYPE == "MSWin" ]]
	then
		CMD="$WCMD"
	else
		CMD="$LCMD"
	fi
}

function DumpInfo(){
	printf '<systeminfo host="%s" type="%s"' "$HOSTNAME" "$OSTYPE"
	printf ' date="%s" time="%s">\n' "$(date '+%F')" "$(date '+%T')"
	# readarray 입력한 모든행을 읽어서 다음 변수CMDS 에 저장
	readarray CMDS
	# 입력된 값을 순회 하기
	for ALINE in "${CMDS[@]}"
	do
		# 주석무시
		# if문 한줄에 쓸때는 ; 써줘야 함
		if [[ ${ALINE:0:1} == '#' ]] ; then continue ; fi

		SepCmds

		if [[ ${CMD:0:3} == N/A ]]
		then
			continue
		else
			printf "<%s>\n" $TAG
			$CMD
			printf "</%s>\n" $TAG
		fi
	done
	printf "</systeminfo>\n"
}

# $() 실행값을 저장할때
OSTYPE=$(./osdetect.sh)
HOSTNM=$(hostname)
# 변수를 문자열안에 선언하는 방법${}
# 정보저장 파일
TMPFILE="${HOSTNM}.info"
DumpInfo > $TMPFILE 2>&1