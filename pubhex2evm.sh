#!/bin/bash

# Read content of file in the first argument and concatenate at terminal
cat $1 | \
# Compute Keccak256 sum of hexed public key literal and express in lowercase hexadecimal
keccak-256sum -x -l | \
# Remove the trailing "[:space:][:hyphen:]" characters
tr -d ' -' | \
# Retain only the last 41 characters (inclusive of EOL)
tail -c 41 | \
# Prepend the address with "0x"
xargs -I % echo 0x%
