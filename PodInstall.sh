#!/bin/sh

# Local podspec install script
# Written by Aron Bury 26/02/2013
# Adding SQLayout

scriptPath=`pwd -P`

rm -rf ~/.cocoapods/ABPadLockScreen
pod repo add ABPadLockScreen git://github.com/abury/ABPadLockScreen.git
pod push ABPadLockScreen