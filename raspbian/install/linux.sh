#!/bin/bash
shellPath=`pwd`
WorkPath=$HOME/raspbian

function get_raspbian_src()
{
    	if [ ! -d $WorkPath ]; then
		mkdir $WorkPath
    	fi
	if [ ! -d $WorkPath/linux ]; then	
		cd $WorkPath
		git clone -b rpi-4.19.y --depth=1 https://github.com/raspberrypi/linux
	else
		cd $WorkPath/linux 
		git pull	
	fi
}

get_raspbian_src



