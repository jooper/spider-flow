#!/bin/bash
ps -ef | grep spider-flow | grep -v grep | awk '{print $2}' | xargs kill -9
echo "killed"