#!/bin/bash

if [[ $1 == "set" ]]; then
  echo $2 > $PWD/.ekko
  exit 0
fi

git_dir=$(git rev-parse --show-toplevel 2>/dev/null)
if [[ ! -f $PWD/.ekko ]]; then
    if [[ $? != "0" ]]; then
      echo "Can't find an .ekko file, can't find git root. Are we in the right dir?"
      exit 1
    elif [[ ! -f $git_dir/.ekko ]]; then
      echo "Found the .git dir, couldnt find an .ekko file in it"
      exit 1
    elif [[ -f $git_dir/.ekko ]]; then
      ekko_file="$git_dir/.ekko"
    fi
elif [[ -f $PWD/.ekko ]]; then
  ekko_file="$PWD/.ekko"
fi


if [ ! -z $git_dir ] && [ ! grep -Fxq ".ekko" $git_dir/.gitignore ]; then
  echo ".ekko" >> $git_dir/.gitignore
fi

echo "Ekko started"
echo "~The timeline was already this broken when I found it. I swear.~"
echo "running $ekko_file"
. $ekko_file
