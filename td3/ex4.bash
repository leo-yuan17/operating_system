#!/bin/bash
if [ $# -ne 1 ]; then
    echo "用法: $0 <文件名>"
    exit 1
fi
if [ ! -r "$1" ]; then
    echo "错误: $1 不可读取。"
    exit 1
fi
is_palindrome() {
    local word=$1
    local reversed=$(echo "$word" | rev)
    if [ "$word" = "$reversed" ]; then
        return 0
    else
        return 1
    fi
}
while IFS= read -r line; do
    for word in $line; do
        # 去除单词中的非字母字符
        clean_word=$(echo "$word" | tr -cd '[:alpha:]' | tr '[:upper:]' '[:lower:]')#管道符运算从左到右
        if [ -n "$clean_word" ] && is_palindrome "$clean_word"; then
            echo "$clean_word"
        fi
    done
done < "$1"