#!/bin/bash
shellPath=`pwd`
WorkPath=$HOME/raspbian

function get_raspbian_gcc()
{
    	if [ ! -d $WorkPath ]; then
		mkdir $WorkPath
    	fi
    	if [ ! -f $WorkPath/xtensa-lx106-elf.tar.gz ]; then
        	cd $WorkPath
		wget -O xtensa-lx106-elf.tar.gz https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-1.22.0-92-g8facf4c-5.2.0.tar.gz
    	fi
	if [ ! -d  $WorkPath/xtensa-lx106-elf/bin ]; then
        	cd $WorkPath
		mkdir xtensa-lx106-elf
		tar -xzvf $shellPath/xtensa-lx106-elf.tar.gz  -C xtensa-lx106-elf --strip-components 1 
		echo -e "finish esp8266 xtensa-lx106-elf \n${Line}"   	
	else
		echo -e "exist esp8266 xtensa-lx106-elf \n${Line}"
	fi
	if [ -d  $WorkPath/xtensa-lx106-elf/bin ]; then
		echo 'export PATH='$WorkPath'/xtensa-lx106-elf/bin:$PATH' >> ~/.bashrc
		echo -e "export xtensa-lx106-elf path\n${Line}"   	
	fi	
}

get_raspbian_gcc
