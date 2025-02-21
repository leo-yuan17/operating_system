#!/bin/bash

# 定义递归函数来遍历目录树
traverse_directory() {
    local dir="$1"
    local indent="$2"

    # 遍历目录中的所有文件和子目录
    for item in "$dir"/*; do
        if [ -d "$item" ]; then
            # 如果是目录
            local dirname=$(basename "$item")
            echo "${indent}|-- $dirname"
            # 递归调用函数处理子目录，增加缩进
            traverse_directory "$item" "$indent  "
        elif [ -f "$item" ]; then
            # 如果是文件
            local filename=$(basename "$item")
            echo "${indent}+-- $filename"
        fi
    done
}

# 检查是否提供了参数
if [ $# -eq 0 ]; then
    # 如果没有参数，使用当前目录
    target_dir="."
else
    # 如果有参数，使用传入的目录
    target_dir="$1"
fi

# 检查目录是否存在
if [ ! -d "$target_dir" ]; then
    echo "错误: $target_dir 不是一个有效的目录。"
    exit 1
fi

# 调用递归函数开始遍历
traverse_directory "$target_dir" ""