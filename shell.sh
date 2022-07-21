#!/bin/bash
echo "choose cpu or mem to check 3rd most used process details depends on cpu or mem"
read input
echo "###################################"
echo "3rd most $input used process details"
echo "###################################"
echo "please 'cat output.txt' for results"

cmd=`ps -eo cmd,pid,%cpu,%mem, --sort=-%$input | head -n 4 | tail -n 1 | awk '{ print $1 }'`
pid=`ps -eo cmd,pid,%cpu,%mem, --sort=-%$input | head -n 4 | tail -n 1 | awk '{ print $2 }'`
cpu=`ps -eo cmd,pid,%cpu,%mem, --sort=-%$input | head -n 4 | tail -n 1 | awk '{ print $3 }'`
mem=`ps -eo cmd,pid,%cpu,%mem, --sort=-%$input | head -n 4 | tail -n 1 | awk '{ print $4 }'`

port=`netstat -plnt  2>/dev/null | grep $pid | awk '{ print $4 }'`

if [ -z $port]
then
	port="no port for 3rd most resource pid $pid"
else
	port=`$port | cut -d ":" -f 2`
fi

cat > output.txt <<EOF
Process_Name: $cmd
%CPU_Used: $cpu
%Memory_Used: $mem
PORT: $port
PID: $pid
EOF

