#!/bin/bash
#title           :auto_install.sh
#description     :This script will make a Onset server automaticaly on linux server.
#author		     :Chilli
#date            :12/15/2019
#version         :1.0
#usage		     :./auto_install.sh
#notes           :Make sure you are on Ubuntu 18.04, Debian 9 or CentOS 7.
#===================================================================================#

# Global variable #
ROOT_UID=0     # Only users with $UID 0 have root privileges.
E_NOTROOT=87   # Non-root exit error.
LANGAGE=0      # [FR]LANGAGE=0 , [EN]LANGAGE=1

# Translation - ${exemple[0]} to french #
declare -a root_required=("\e[7mVous devez être en root pour lancer le scrip.\e[0m" "\e[7Must be root to run this script.\e[0m")
declare -a root_access=("\e[7mPermision Root : \e[32mOK\e[0m" "\e[7mRoot Permission : \e[32mOK\e[0m")

#===================================================================================#
# Run as root btw #
clear
if [ "$UID" -ne "$ROOT_UID" ]
then
    echo -en ${root_required[$LANGAGE]}
    echo
    exit $E_NOTROOT
else
    echo -en ${root_access[$LANGAGE]}
    echo
fi

#===================================================================================#
# Print startup message #
for i in {232..255}
do
    echo -en "\e[38;5;${i}m-\e[0m"
done
echo -en "\e[38;5;255m----------------\e[0m"
for i in {255..232}
do
    echo -en "\e[38;5;${i}m-\e[0m"
done
echo
echo -e "\e[0m               - \e[92mO\e[0;4mnset\e[0m \e[92mA\e[0;4muto\e[0m \e[92mI\e[0;4mnstaller\e[0m \e[92mB\e[0;4my\e[0m \e[92mC\e[0;4mhilli\e[0m -\e[0m"
echo
echo -e "\e[92m    W\e[0melcome to the best way to set up your own onset server\e[0m"
echo -e "\e[92m    b\e[0mased on Frederic2ec Framework to get RP packages.\e[0m"
echo
for i in {232..255}
do
    echo -en "\e[38;5;${i}m-\e[0m"
done
echo -en "\e[38;5;255m----------------\e[0m"
for i in {255..232}
do
    echo -en "\e[38;5;${i}m-\e[0m"
done
echo