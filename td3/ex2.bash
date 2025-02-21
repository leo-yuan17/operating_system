#!/bin/bash

# 定义帮助函数，用于输出脚本的使用说明
print_usage() {
    echo "用法: $0 [选项] [--] 命令名..."
    echo "选项:"
    echo "  -a    列出找到的所有可执行文件实例（而不是每个命令只列出第一个）"
    echo "  -s    不输出内容，如果找到任何可执行文件则返回 0，如果未找到则返回 1"
}

# 初始化选项标志
list_all=false
silent=false

# 处理选项
while [[ $# -gt 0 ]]; do
    case "$1" in
        -a)
            list_all=true
            shift
            ;;
        -s)
            silent=true
            shift
            ;;
        --)
            shift
            break
            ;;
        -*)
            echo "错误: 未知选项 $1"
            print_usage
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

# 检查是否至少提供了一个命令名
if [[ $# -eq 0 ]]; then
    print_usage
    exit 1
fi

# 初始化找到命令的标志
found=false

# 遍历每个命令名
for command in "$@"; do
    # 用于存储当前命令找到的可执行文件列表
    found_commands=()
    # 遍历 $PATH 中的每个目录
    IFS=: read -ra dirs <<< "$PATH"
    for dir in "${dirs[@]}"; do
        file="$dir/$command"
        # 检查文件是否存在且可执行
        if [[ -x "$file" ]]; then
            found=true
            if $list_all; then
                found_commands+=("$file")
            else
                if ! $silent; then
                    echo "$file"
                fi
                break
            fi
        fi
    done
    # 如果使用了 -a 选项，输出所有找到的可执行文件
    if $list_all; then
        for found_command in "${found_commands[@]}"; do
            if ! $silent; then
                echo "$found_command"
            fi
        done
    fi
done

# 根据是否找到可执行文件返回相应的退出状态码
if $found; then
    exit 0
else
    exit 1
fi