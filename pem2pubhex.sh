#!/bin/bash

cat $1 | head -3 | tail -2 | base64 --decode | xxd -c 0 -ps | tail -c 129
