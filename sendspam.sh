#!/bin/bash
echo Enter your message:
while read msg
do
	[ -z "$msg" ] && break;
	fmsg+=$msg"\n"

done

ct=`echo $1 | cut -d"@" -f 2 `

for i in {0..5};
do
(
	echo helo $ct 
	sleep 2
	echo mail from: $1
	sleep 2
	echo rcpt to: $2
	sleep 2
	echo data
	sleep 2
	echo Subject: "I'm the President!"
	sleep 2
	echo -e $fmsg 
	sleep 2
	echo .
	sleep 2
	echo 
)|telnet mail.cs.ucr.edu 25

done
