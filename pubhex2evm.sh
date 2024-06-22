#!/bin/bash

cat $1 | keccak-256sum -x -l | tr -d ' -' | tail -c 41 | xargs -I % echo 0x%
