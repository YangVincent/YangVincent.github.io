#!/bin/zsh
echo "Pushing"
git push

echo "Deploying with JGD"
jgd -b master -r code
