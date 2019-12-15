#!/bin/bash     
#title           :auto_install.sh
#description     :This script will make a Onset server automaticaly on linux server.
#author		     :Chilli
#date            :12/15/2019
#version         :1.0
#usage		     :./auto_install.sh
#notes           :Make sure you are on Ubuntu 18.04, Debian 9 or CentOS 7.
#===================================================================================#

#Global variable
ROOT_UID=0     # Only users with $UID 0 have root privileges.
E_NOTROOT=87   # Non-root exit error.
LANGAGE=0      # [FR]LANGAGE=0 , [EN]LANGAGE=1

#Translation - ${exemple[0]} to french
declare -a root_required=("\e[7mVous devez être en root pour lancer le scrip.\e[0m" "\e[7Must be root to run this script.\e[0m")
declare -a root_access=("\e[7mPermision Root : \e[32mOK\e[0m" "\e[7mRoot Permission : \e[32mOK\e[0m")

# Run as root, of course.
clear
if [ "$UID" -ne "$ROOT_UID" ]
    then
        echo -e ${root_required[$LANGAGE]}
        echo -e "\n"
        exit $E_NOTROOT
else
    echo -e ${root_access[$LANGAGE]}
    echo -e "\n"
fi