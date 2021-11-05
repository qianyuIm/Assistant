#!/bin/bash
# 1. 首先生成 iconfontIcons
echo "1. 首先生成 iconfontIcons"
python3 iconFont_translate.py;
# 2. 返回上级目录
echo "2. 返回上级目录"
cd ..
echo "当前目录 => "$PWD""
echo "3. pod install"
pod install;
