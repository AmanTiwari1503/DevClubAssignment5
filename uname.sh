#!/bin/bash
#File reading
file_name="$1"
user_name="$2"
OIFS="$IFS"
if [ "$#" -lt 2 ]; then
	exit 1
fi
if [ ! -r "$file_name" ]; then
	exit 1
fi
if [[ $"$file_name" != *".txt" ]]; then
	exit 1
fi
flag=0
while read -r line || [[ -n "$line" ]];
do
	if [[ "$line" != *":x:"*":"*":"*":"*":"* ]]; then 
		exit 1
	fi
	IFS=":"
	read -r -a arr <<< "$line"
	if [ "${arr[0]}" == "$user_name" ]; then 
		temporary="${arr[4]}"
		let flag+=1 
	fi
	IFS=$OIFS
done < "$file_name"
if [ "$flag" -eq 1 ]; then
	echo $temporary
else
	echo "Invalid Username"
	exit 1
fi


