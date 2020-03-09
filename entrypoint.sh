#!/bin/bash

set -e

function echo_and_run() {
  echo -n "$@"
  echo
  "$@"
}

function action_output() {
  echo "::set-output name=$1::$2"
}

POSITION="$INPUT_POSITION"
FILE_BASENAME="$INPUT_FILE_BASENAME"
FILE_PATH="$INPUT_FILE_PATH"

FILE="$FILE_BASENAME.tar"
WILDCARD="*"

echo "FILE_PATH: $FILE_PATH";
if [[ "$FILE_PATH" == *"$WILDCARD"* ]]; then
  COUNT=`find $POSITION -path "$FILE_PATH" | wc -l`
  if [ $COUNT == '0' ]; then
    echo "not exists."
    exit 1
  fi

  echo_and_run find $POSITION -path "$FILE_PATH" -type d \
                -exec tar rf "$FILE" \
                {} ';'
else
  if [ -f $FILE_PATH ]; then
    echo_and_run tar -cf "$FILE" "$POSITION/$FILE_PATH"
  elif [ -d $FILE_PATH ]; then
    echo_and_run tar -cf "$FILE" "$POSITION/$FILE_PATH"
  else
    echo "not exists."
    exit 1
  fi
fi

echo_and_run gzip "$FILE" 

echo -n "curl -F \"file=@$FILE.gz\" 'https://file.io/'"
echo
RESPONSE=`curl -F "file=@$FILE.gz" 'https://file.io/'`
echo "$RESPONSE"

action_output 'response' "$RESPONSE"
