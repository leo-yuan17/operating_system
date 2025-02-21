#!/bin/bash
est_numeique() {
	if [[ $1 =~ ^[0-9]+$ ]]; then
		echo "$1 是一个数字。"
	else
		echo "$1 不是一个数字。"
	fi
}

for arg in "$@"; do
	est_numeique "$arg"
done
