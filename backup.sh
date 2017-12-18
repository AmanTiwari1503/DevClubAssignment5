#!/bin/bash
#File syncer
dir1="$1"
dir2="$2"
if [ "$#" -ne 2 ]; then
	exit 1
fi
if ! [ -d "$dir1" ] || ! [ -d "$dir2" ]; then
	exit 1
fi
echo "Files copied from $dir1 to $dir2"
for i in "$dir1"/*
do
	path1="$i"	
	file1=$(basename $path1)	
	flag=0
	for j in "$dir2"/* 
	do
		path2="$j"	
		file2="$(basename $path2)"
		if [ "$file1" == "$file2" ]; then
		let flag+=1
		fi
	done
	if [ "$flag" -ne 1 ]; then
		cp "$i" "$dir2"
		echo $file1
	fi
done
echo "Files copied from $dir2 to $dir1"
for i in "$dir2"/*
do
	path1="$i"	
	file1="$(basename $path1)"
	flag=0
	for j in "$dir1"/* 
	do
		path2="$j"	
		file2="$(basename $path2)"
		if [ "$file1" == "$file2" ]; then
		let flag+=1
		fi
	done
	if [ "$flag" -ne 1 ]; then
		cp "$i" "$dir1"
		echo $file1
	fi
done
