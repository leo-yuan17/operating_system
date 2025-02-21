#!/bin/bash
if [ $# -ne 1 ];then
	echo "need an argument"
	exit 1
fi
if [ ! -f "$1" ];then
	echo "file doesn't exist "
	exit 1
fi
tac "$1"

