#!/bin/bash
#My First Script
if ! [ -d "$1" ];then
	exit -1 
elif [ "$#" -eq 1 ];then
	my=0
	for i in "$1"/*
	do
	if [ -f "$i" ] && ! [ -h "$i" ];then
		let my+=1
	fi
	done
	echo "$my"
elif [ "$#" -eq 2 ];then
	my=0
	for i in "$1"/*
	do
	if [ -f "$i" ] && [[ $"$i" == *"$2" ]] && ! [ -h "$i" ];then
		let my+=1
	fi
	done
	echo "$my"
else
	exit -1
fi
