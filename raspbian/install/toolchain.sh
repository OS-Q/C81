#!/bin/bash
shellPath=`pwd`
WorkPath=$HOME/raspbian

function get_raspbian_gcc()
{
    	if [ ! -d $WorkPath ]; then
		mkdir $WorkPath
    	fi
    	if [ ! -d $WorkPath/tools ]; then
        	cd $WorkPath
		git clone --depth=1 https://github.com/raspberrypi/tools
    	else
		cd $WorkPath/tools 
		git pull	
	fi
	if [ -d  $WorkPath/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin ]; then
		echo 'export PATH='$WorkPath'/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:$PATH' >> ~/.bashrc
		echo -e "export gcc-linaro-arm-linux-gnueabihf-raspbian-x64 path\n${Line}"   	
	fi	
}

get_raspbian_gcc
