## Files and Data
PREV_TOTAL=0
PREV_IDLE=0
cpuFile="/tmp/.cpu_usage"

## Get CPU usage
get_cpu() {
	if [[ -f "${cpuFile}" ]]; then
		fileCont=$(cat "${cpuFile}")
		PREV_TOTAL=$(echo "${fileCont}" | head -n 1)
		PREV_IDLE=$(echo "${fileCont}" | tail -n 1)
	fi

	CPU=($(grep '^cpu ' /proc/stat))
	unset CPU[0]
	IDLE=${CPU[4]}
	TOTAL=0

	for VALUE in "${CPU[@]:0:4}"; do
		((TOTAL+=VALUE))
	done

	if [[ -n "${PREV_TOTAL}" && -n "${PREV_IDLE}" ]]; then
		DIFF_IDLE=$((IDLE - PREV_IDLE))
		DIFF_TOTAL=$((TOTAL - PREV_TOTAL))
		DIFF_USAGE=$(((1000 * (DIFF_TOTAL - DIFF_IDLE) / DIFF_TOTAL + 5) / 10))
		((DIFF_USAGE < 5)) && DIFF_USAGE=0
		echo "${DIFF_USAGE}"
	else
		echo "?"
	fi

	echo "${TOTAL}" > "${cpuFile}"
	echo "${IDLE}" >> "${cpuFile}"
}

get_mem() {
	mem_used=$(free -m | grep Mem | awk '{print $3}')
	mem_total=$(free -m | grep Mem | awk '{print $2}')
	mem_percent=$(bc <<< "scale=0; ($mem_used * 100) / $mem_total")
	echo "$mem_percent"
}

if [[ "$1" == "--cpu" ]]; then
	get_cpu
elif [[ "$1" == "--mem" ]]; then
	get_mem
fi
