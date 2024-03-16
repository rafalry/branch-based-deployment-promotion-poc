#!/bin/bash

echo $(($(cat counter.txt) + 1)) > counter.txt
git add -A
git commit -m "[INFRA] Increase counter to $(cat counter.txt)"
git push
