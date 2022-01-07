#!/bin/bash
echo helloworld - RANDOM:$RANDOM
while true; do echo $!; sleep 1; done
# ^^ This makes it a infinite program, so it mimics our express server, Yikes!
echo byeworld