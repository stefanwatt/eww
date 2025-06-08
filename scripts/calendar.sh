#!/run/current-system/sw/bin/bash

case "$1" in
    --time)
        date +"%H:%M:%S"
        ;;
    --day-of-month)
        date +"%d"
        ;;
    --month)
        date +"%B"
        ;;
    --year)
        date +"%Y"
        ;;
    --day-of-week)
        date +"%A"
        ;;
    *)
        echo "Invalid argument. Use one of: --time, --day-of-month, --month, --year, --day-of-week"
        exit 1
        ;;
esac

