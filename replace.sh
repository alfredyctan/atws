#!/bin/bash

for FILE in `find $1/* -type f`
do
	if [[ ! $FILE =~ ^.*zip$ ]]; then
		TEMP_FILE=`mktemp`
		cat $FILE | sed "s/$2/$3/g" > $TEMP_FILE
		mv $TEMP_FILE $FILE
	fi
done
