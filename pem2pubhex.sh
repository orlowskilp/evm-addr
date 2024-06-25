#!/bin/bash

# Read content of file in the first argument and concatenate at terminal
cat $1 | \
# Retain only first 3 lines (i.e. remove "-----END PUBLIC KEY-----" line)
head -3 | \
# Retain only the last 2 lines (i.e. remove "-----BEGIN PUBLIC KEY----- line)
tail -2 | \
# Decode base64 to binary
base64 --decode | \
# Convert binary to hex as one line and print to terminal
xxd -c 0 -ps | \
# Retain only the last 129 characters (inclusive of EOL)
tail -c 129
