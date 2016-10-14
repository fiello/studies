#!/bin/sh

rm -rf ./main
rm -rf ./main.swift
localPlayground=$(find . -iname "*.play*")
target_exec=main_playground

echo Compiling files from: $localPlayground ...
ln -sf ./$localPlayground/Contents.swift main.swift
find ./$localPlayground/Sources -iname "*.swift" | xargs swiftc -o $target_exec main.swift

if [ -f "$target_exec" ]
then
  echo Running main executable ...
  echo
  ./$target_exec
else
  echo Unable to find target executable, see errors above
fi






