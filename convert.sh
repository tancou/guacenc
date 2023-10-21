#! /bin/ash

setup () {
    if [[ -z "$1" ]]; then
        DIR='/record'
    else
        DIR="$1"
    fi
    UNCONVERTED=$(find ${DIR} -type f \! -iname "*.m4v" \! -iname "*.nfo" -mmin +3 -exec awk -F';' 'NR==1 && /size/{if (system("test ! -f " FILENAME ".m4v")==0) print FILENAME}' {} \;)
}

convert () {
    for FILE in ${UNCONVERTED}; do
        SIZE=$(awk -F';' '/size/ {gsub("[[:digit:]].size,[[:digit:]].[[:digit:]],[[:digit:]].","",$1); gsub(",[[:digit:]].","x",$1); print $1}' ${FILE})
        if [[ "${SIZE}" == "0x0" ]]; then SIZE="1280x720"; fi
        /usr/local/bin/guacenc -s ${SIZE} ${FILE}
    done
}

main () {
	if [[ "${AUTOCONVERT}" == "true" ]] || [[ ! -z "${1}" ]]; then
        setup $@
		convert
    fi

	if [[ -z "${1}" ]]; then
        sleep ${AUTOCONVERT_WAIT:-60}
        main $@
    fi
}

main $@
