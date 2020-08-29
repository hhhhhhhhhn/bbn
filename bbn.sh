#!/bin/bash

[ -z $NOTES_DIR ] && [ ! -d $NOTES_DIR ] && echo "NOTES_DIR enviroment variable doesn't exist or is not a directory." && exit 1

[ -z $1 ] && NOTE="main" || NOTE=$1

TEMP_FILE="${NOTES_DIR}/temp.file"
FILE="${NOTES_DIR}/${NOTE}.md"
DATE="$(date +'%D (%A)')"

touch $FILE

grep -q "$DATE" $FILE && DATE="" || DATE="\n# ${DATE}\n\n" #If date already in file.

nano $TEMP_FILE -t -x # Arguments hide shortcuts and save without asking.

echo -e "${DATE}$(<$TEMP_FILE)\n" >> $FILE

rm $TEMP_FILE
