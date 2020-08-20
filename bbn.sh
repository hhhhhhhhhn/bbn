#!/bin/bash

if [ -z $NOTES_DIR ] || [ ! -d $NOTES_DIR ]; then
	echo "NOTES_DIR enviroment variable doesn't exist or is not a directory."
	exit 1
fi

if [ -z $1 ]; then # Default journal
	NOTE="main"
else
	NOTE=$1
fi

TEMP_FILE="${NOTES_DIR}/temp.file"
FILE="${NOTES_DIR}/${NOTE}.md"
DATE="$(date +'%D (%A)')"

touch $FILE

if grep -q "$DATE" $FILE; then # If curret date is in file.
	DATE=""
else
	DATE="\n# ${DATE}\n\n"
fi

nano $TEMP_FILE -t -x # Arguments hide shortcuts and save without asking.

echo -e "${DATE}$(cat $TEMP_FILE)\n" >> $FILE

rm $TEMP_FILE
