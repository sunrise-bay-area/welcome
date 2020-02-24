#!/bin/bash

cd $(dirname "$0")/..

if [ $# -eq 0 ]
  then
    echo "Please supply a PR number"
    exit 1
fi

TARGET="dev/$1"

if [ -d $TARGET ]
then
  while true; do
    read -p "PR folder exists, do you want to overwrite? Y/n " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
  done
fi

mkdir -p $TARGET
cp -a assets/. $TARGET/assets
cp index.html $TARGET/index.html
git add $TARGET/.
git status

while true; do
  read -p "Release to dev root? Y/n " yn
  case $yn in
      [Yy]* ) break;;
      [Nn]* ) exit;;
      * ) echo "Please answer yes or no.";;
  esac
done

cp -a assets/. dev/assets/
cp index.html dev/index.html
git add dev/.
git status
