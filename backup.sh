#!/bin/bash
#File syncer
if [ "$#" -ne 2 ]; then
	exit 1
fi
if ! [ -d "$1" ] || ! [ -d "$2" ]; then
	exit 1
fi
di1="$1"
di2="$2"
backup_method()
{
dir1="$1"
for i in "$dir1"/*
do
	if [ -d "$i" ]; then
		backup_method "$i" "$2"
		
	fi
	path1="$i"	
	file1="$(basename $path1)"	
	sync_check "$file1" "$path1" "$2"
	local flag=$?
	if [ "$flag" -ne 1 ]; then
		cp "$i" "$2"
		direc=$(basename $"$dir1")
		if [ "$dir1" != "$di1" ] && [ "$dir1" != "$di2" ]; then
			echo -n "$direc/"
		fi
		echo $file1
	fi
done
}
sync_check()
{
f=0
dir2="$3"
for j in "$dir2"/*
do
	if [ -d "$j" ]; then
		sync_check "$1" "$2" "$j"
		local f=$?
		if [ "$f" -eq 1 ]; then
		break
		fi
	else
		path2="$j"
		file2="$(basename $path2)"
		if [ "$1" == "$file2" ]; then
			let f+=1
			break
		fi
	fi
done
return $f
}
echo "Files copied from $1 to $2"
backup_method "$1" "$2"
echo "Files copied from $2 to $1"
backup_method "$2" "$1"
