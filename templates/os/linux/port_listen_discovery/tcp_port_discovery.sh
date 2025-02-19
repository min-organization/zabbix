#!/usr/bin/env bash
# https://github.com/min-organization/zabbix

PORT_CONFIG=/etc/zabbix/ports.conf

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

GEN_JSON(){
    length=`egrep -v "^#|^$" ${PORT_CONFIG} | wc -l`
    count=0
    printf "{\n"
    printf "\"data\":\n[\n"
    egrep -v "^#|^$" ${PORT_CONFIG} | while read port service
    do
        printf "{\n"
        printf "\"{#PORT}\": \"$port\",\n\"{#SERVICE}\": \"$service\"}"
        count=$(( $count + 1 ))
        if [ $count -lt $length ];then
        printf ',\n'
        fi
    done
    printf "\t\n]\n"
    printf "}\n"
}

if [ -r ${PORT_CONFIG} ];then
    (test -x /bin/tr && GEN_JSON | /bin/tr -d '[:space:]') || GEN_JSON
else
    echo "{\"data\":[]}"
fi
