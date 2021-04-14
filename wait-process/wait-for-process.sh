#!/bin/bash

if ! kill -0 $1; then
  echo "Process $1 doesn't exist."
  exit 1
fi

while kill -0 $1; do
  echo "Still running!"
  sleep 30
done

echo "Process $1 finished at $(date)."
