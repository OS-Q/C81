#!/bin/bash
shellPath=`pwd`
WorkPath=$HOME/raspbian

function get_raspbian_src()
{
    	if [ ! -d $WorkPath ]; then
		mkdir $WorkPath
    	fi
	if [ ! -d $WorkPath/ESP8266_RTOS_V2 ]; then	
		cd $WorkPath
		git clone -b release/v2.x.x --depth=1 https://github.com/espressif/ESP8266_RTOS_SDK.git ESP8266_RTOS_V2
	fi
	if [ -d $WorkPath/ESP8266_RTOS_V2/driver_lib ]; then		
		echo 'export IDF_PATH='$SDKPath'/ESP8266_RTOS_V2' >> ~/.bashrc
		echo -e "done ESP8266_RTOS_SDK path !\n${Line}"   	
	else
		echo -e "exist ESP8266_RTOS_V2 folder \n${Line}"
	fi	
}

get_raspbian_src



