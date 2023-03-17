#!/bin/bash
echo "starting a random server in python"
echo "http://`hostname`:8000/"
prefix="http://`hostname`:8000"
#find . -name \*.bin\* -exec echo "$prefix$(basename {})" \; HAH THIS DOES NOT WORK.
for i in `ls *.bin*`; do
  echo $prefix/$i
done
python -m http.server 8000
