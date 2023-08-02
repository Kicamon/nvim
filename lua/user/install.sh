#! /bin/bash

osname=`head --lines=3 /etc/os-release | grep ID`
len=`expr length ${osname}`
osname=`expr substr "$osname" 4 4`
if [ "$osname" == "arch" ]
then
	sudo pacman -S python-black clang js-beautify lua nodejs npm python pyright python-pynvim yarn
fi

cp ~/.config/nvim/lua/usr/format ~/
