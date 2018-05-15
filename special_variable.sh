#!/bin/sh

echo $0
echo $#
echo $@
echo $*

echo $?
echo $$
echo $!

for TOKEN in $@
do
   echo $TOKEN
done
