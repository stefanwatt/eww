#!/run/current-system/sw/bin/bash
eww ping &>/dev/null && eww daemon
window=dashboard
if eww active-windows | grep -q "$window"; then
    eww close $window
else
    eww open $window
fi
