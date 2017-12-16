#!/bin/bash
#Arithmetic operators
file_name="$1"
arb="$IFS"
if [ "$#" -ne 1 ]; then
	exit 1
fi
if [ ! -r "$file_name" ]; then
	exit 1
fi
value=0
while read -r line || [[ -n "$line" ]];
do
	if [[ "$line" != *" "* ]]; then
		exit 1
	fi
	IFS=" "
	flag=0
	read -r -a arr <<< "$line"
	p="${arr[1]}"
	myvalue="${arr[0]}"
	if [ "$p" == "+" ]; then
		let value+=myvalue
		let flag+=1
	fi
	if [ "$p" == "-" ]; then
		let value-=myvalue
		let flag+=1
	fi
	if [ "$p" == "*" ]; then
		let value*=myvalue
		let flag+=1
	fi
	if [ "$p" == "/" ]; then
		let value/=myvalue
		let flag+=1
	fi
	if [ "$flag" -ne 1 ]; then
		exit 1
	fi
	IFS=$arb
done < "$file_name"
echo $value
	
	
