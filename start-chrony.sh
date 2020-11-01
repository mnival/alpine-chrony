#!/bin/sh

_CHRONY_PID="/var/run/chrony/chronyd.pid"
_CHRONY_CONF="/etc/chrony/chrony.conf"

[ -f ${_CHRONY_PID} ] && rm ${_CHRONY_PID}

env | awk 'BEGIN {FS="="} /chronyconf\./ {gsub(/chronyconf\./, ""); if ($2 == "") {$2=" "}; if ($2 != "null") {split($2, i, ";"); for(j in i) {printf("%s %s\n", $1, i[j])}}}' > ${_CHRONY_CONF}

exec chronyd -d -s -u chrony
