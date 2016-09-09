#!/bin/sh

SH=`basename "$0"`

python /home/sample.py
RC=$? # exit code for above script

if [ $RC -ne 0 ]; then
	for errorlog in *errorlog.txt; do
		[ -e "$errorlog" ] && echo "Please see attached error log for details." | mutt -s $(hostname)": ERROR!! "$SH -a ./$errorlog -- admin@andrewrgoss.com
		done
	exit $RC
fi
	
echo "done"