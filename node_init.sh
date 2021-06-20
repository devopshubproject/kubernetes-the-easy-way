#!/bin/bash
set -x

run=$(cat join.sh | sed '1,2d')

eval $run