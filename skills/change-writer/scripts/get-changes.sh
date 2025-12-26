#!/bin/bash
# A simple script to summarize changes
git status -s
echo "---"
git diff --stat
