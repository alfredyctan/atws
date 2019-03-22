#!/bin/bash
if [ $# -lt 1 ]; then
	git
	exit 0
fi
WORKING=`pwd`
for DIR in `find * -maxdepth 3 -type d`
do
	if [ -d "$DIR/.git" ]; then
		echo ""
		echo "working on $DIR"
		if [[ $DIR =~ .*\.bak$ ]] || [[ $DIR =~ .*\.obs.*$ ]]; then
			echo "skip backup or obsolete project"
		else
			cd $DIR
			echo "git $@"
			git "$@"
			cd $WORKING
		fi
	fi
done

