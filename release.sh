#!/bin/bash
# Usage: ./release.sh <major-minor-patch>
# Author: ChatGPT

if [ $# -eq 0 ]; then
    echo "Usage: ./release.sh <major-minor-patch>"
    exit 1
fi

if [ "$(git branch --show-current)" != "main" ]; then
    echo "当前分支（$(git branch --show-current)）不为 main。"
    echo "你需要先切换到 main 分支再使用。"
    exit 1
fi

name="chore-$(date '+%Y%m%d')-release-$1"
echo "发布为：$name"

# 检查本地是否存在同名分支
if git rev-parse --verify --quiet "$name"; then
    echo "分支 $name 已存在，请删除或使用其他分支名。"
    exit 1
fi

# 创建并切换到新分支
git checkout -b "$name"

# 提交空的更改
git commit --allow-empty -m "chore: release $1" -m "Release-As: $1"

# 推送新分支到远程仓库
git push --set-upstream origin "$name"

# 切换到 main 分支
git checkout main

# 删除本地分支
git branch -d "$name"

# 检查操作系统类型，并在浏览器里打开 PR 页面
if [[ "$(uname -s)" == "Linux" ]]; then
    xdg-open "https://github.com/ligen131/equal_to_p/pull/new/$name"
elif [[ "$(uname -s)" == "MINGW"* ]]; then
    start "https://github.com/ligen131/equal_to_p/pull/new/$name"
else
    echo "不支持的操作系统"
fi