#!/bin/bash

git remote add upstream https://github.com/raspberrypi/linux.git
git fetch upstream
git rebase upstream/rpi-4.0.y

