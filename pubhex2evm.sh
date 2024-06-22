#!/bin/bash

echo 0x$(cat $1 | keccak-256sum -x -l | tr -d ' -' | tail -c 41)
