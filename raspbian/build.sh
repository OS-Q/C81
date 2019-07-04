#!/bin/bash

export WorkPath=`pwd`

## Root Password
for ((i = 0; i < 5; i++)); do
	PASSWD=$(whiptail --title "Raspbian build system" \
		--passwordbox "Enter root password. Don't use root or sudo run it" \
		10 60 3>&1 1>&2 2>&3)
	if [ $i = "4" ]; then
		whiptail --title "Note Qitas" --msgbox "Invalid password" 10 40 0	
		exit 0
	fi

	sudo -k
	if sudo -lS &> /dev/null << EOF
$PASSWD
EOF
	then
		i=10
	else
		whiptail --title "Raspbian build System" --msgbox "Invalid password, Pls input corrent password" \
		10 40 0	--cancel-button Exit --ok-button Retry
	fi
done

echo $PASSWD | sudo ls &> /dev/null 2>&1

function port_config()
{
	sudo usermod -a -G dialout $USER 
}
function apt_install()
{
	sudo apt install -y gcc wget make flex bison gperf gawk grep
	sudo apt install -y gettext automake flex texinfo libtool libtool-bin libncurses-dev 
	sudo apt install -y python python-dev python-pip python-setuptools python-serial python-cryptography python-future
	sudo apt autoremove -y 
}

function set_esp8266_gcc()
{
	str="xtensa-lx106-elf-cc :  "
	ret=`whereis xtensa-lx106-elf-cc`
	if [ ${#ret} -lt ${#str} ]; then
		if [ -f  $WorkPath/scripts/xtensa-lx106.sh ]; then
			chmod +x $WorkPath/scripts/xtensa-lx106.sh
			$WorkPath/scripts/xtensa-lx106.sh
			source  ~/.bashrc
		else
			echo -e "no exist xtensa-lx106.sh \n${Line}"
		fi
	else
		echo -e "have config xtensa-lx106 gcc\n${Line}"
	fi
}

function set_esp32_gcc()
{
	str="xtensa-esp32-elf-cc :    "
	ret=`whereis xtensa-esp32-elf-cc`
	if [ ${#ret} -lt ${#str} ]; then
		if [ -f  $WorkPath/scripts/xtensa-esp32.sh ]; then
			chmod +x $WorkPath/scripts/xtensa-esp32.sh
			$WorkPath/scripts/xtensa-esp32.sh 
			source  ~/.bashrc
		else
			echo -e "no shell xtensa-esp32.sh \n${Line}"
		fi
	else
		echo -e "have config xtensa-esp32 gcc\n${Line}"
	fi
}
function set_esp_idf()
{
	if [ -f  $WorkPath/scripts/esp_idf.sh ]; then
		chmod +x $WorkPath/scripts/esp_idf.sh
		$WorkPath/scripts/esp_idf.sh
		source  ~/.bashrc
    	fi
}
function set_esp8266_rtos()
{
	if [ -f  $WorkPath/scripts/esp8266_rtos.sh ]; then
		chmod +x $WorkPath/scripts/esp8266_rtos.sh
		$WorkPath/scripts/esp8266_rtos.sh 
		source  ~/.bashrc
    	fi
}


OPTION=$(whiptail --title "Raspbian build system" \
	--menu "$MENUSTR" 20 60 12 --cancel-button Finish --ok-button Select \
	"0"   "AUTO ESP8266" \
	"1"   "AUTO ESP32" \
	"2"   "GCC tools" \
	"3"   "esp-idf" \
	3>&1 1>&2 2>&3)

# config port user mod	
apt_install
port_config

if [ $OPTION = '0' ]; then
	clear
	echo -e "AUTO ESP8266\n${Line}"
	set_esp8266_gcc
	set_esp8266_rtos	
	exit 0
elif [ $OPTION = '1' ]; then
	clear
	echo -e "AUTO ESP32\n${Line}"
	set_esp32_gcc
	set_esp_idf
	exit 0
elif [ $OPTION = '2' ]; then
	clear
	echo -e "GCC tools\n${Line}"
	set_esp8266_gcc
	set_esp32_gcc
	exit 0
elif [ $OPTION = '3' ]; then
	clear
	echo -e "esp-idf\n${Line}"
	set_esp_idf
	exit 0	
else
	whiptail --title "Raspbian build system" \
		--msgbox "Please select correct option" 10 50 0
	exit 0
fi



exit 0
