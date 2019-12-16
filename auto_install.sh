#!/bin/bash
#title           :auto_install.sh
#description     :This script will make a Onset server automaticaly on linux server.
#author		     :Chilli
#date            :12/15/2019
#version         :1.0
#usage		     :sudo bash auto_install.sh
#notes           :Make sure you are on Ubuntu 18.04, Debian 9 or CentOS 7.
#===================================================================================#

# Global variable #
ROOT_UID=0     # Only users with $UID 0 have root privileges.
E_NOTROOT=87   # Non-root exit error.
LANGAGE=0      # [FR]LANGAGE=0 , [EN]LANGAGE=1
ERROR=1        # Exit with error status
SUCCESS=0      # Exit with success status

# Translation - ${exemple[0]} to french #
declare -a root_required=("\e[7mVous devez être en root pour lancer le scrip.\e[0m" "\e[7Must be root to run this script.\e[0m")
declare -a root_access=("\e[7mPermision Root : \e[32mOK\e[0m" "\e[7mRoot Permission : \e[32mOK\e[0m")
declare -a check_update=("\e[7mVérification des mises à jour [1/3]...\e[0m" "\e[7mChecking for update [1/3]...\e[0m")
declare -a done_update=("\e[7mVérification des mises à jour : \e[32mTerminées\e[0m" "\e[7mChecking for update : \e[32mFinish\e[0m")
declare -a check_upgrade=("\e[7mVérification des mises à jour [2/3]...\e[0m" "\e[7mChecking for update [2/3]...\e[0m")
declare -a done_upgrade=("\e[7mVérification des mises à jour : \e[32mTerminées\e[0m" "\e[7mChecking for update : \e[32mFinish\e[0m")
declare -a check_upgradedist=("\e[7mVérification des mises à jour [3/3]...\e[0m" "\e[7mChecking for update [3/3]...\e[0m")
declare -a done_upgradedist=("\e[7mVérification des mises à jour : \e[32mTerminées\e[0m" "\e[7mChecking for update : \e[32mFinish\e[0m")
declare -a install_curl=("\e[7mInstallation de curl [1/3]...\e[0m" "\e[7mCurl instalation [1/3]...\e[0m")
declare -a done_curl=("\e[7mStatut de curl : \e[32mInstallé\e[0m" "\e[7mCurl status : \e[32mInstalled\e[0m")
declare -a install_nano=("\e[7mInstallation de nano [2/3]...\e[0m" "\e[7mNano instalation [2/3]...\e[0m")
declare -a done_nano=("\e[7mStatut de nano : \e[32mInstallé\e[0m" "\e[7mNano status : \e[32mInstalled\e[0m")
declare -a install_openssl=("\e[7mInstallation de openssl [3/3]...\e[0m" "\e[7mOpenssl instalation [3/3]...\e[0m")
declare -a done_openssl=("\e[7mStatut de openssl : \e[32mInstallé\e[0m" "\e[7mOpenssl status : \e[32mInstalled\e[0m")

clear
#===================================================================================#
# just for output style #
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

#===================================================================================#
# Print startup message #
echo -e "\e[0m               - \e[92mO\e[0;4mnset\e[0m \e[92mA\e[0;4muto\e[0m \e[92mI\e[0;4mnstaller\e[0m \e[92mB\e[0;4my\e[0m \e[92mC\e[0;4mhilli\e[0m -\e[0m"
echo -e "\e[0m                              \e[0;4mv1.0\e[0m"
echo
echo -e "\e[92m    W\e[0melcome to the best way to set up your own onset server\e[0m"
echo -e "\e[92m    b\e[0mased on Frederic2ec Framework to get RP packages.\e[0m"
echo

#===================================================================================#
# just for output style #
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

#===================================================================================#
# Check Language #
echo
echo -e "Choose your language :"
echo
echo -e "[0] : French"
echo -e "[1] : English"
echo
read -p "Write the number here : " check_l
echo

if ! [[ "$check_l" =~ ^[0-9]+$ ]]
then
    read -p "[$check_l] is not a number, please select a language under the list : " check_l
    echo
    if ! [[ "$check_l" =~ ^[0-9]+$ ]]
    then
        echo "[$check_l] is not a number, run again the script and select a language under the list please !"
        exit $ERROR
    elif [$check_l -ne 0 -o $check_l -ne 1]
    then
        read -p "[$check_l] are not on the list, please select a language under the list : " check_l
        echo
        if [-z "$check_l"]
        then
            echo "[$check_l] are not on the list, run again the script and select a language under the list please !"
            exit $ERROR
        fi
    fi
fi

#===================================================================================#
# just for output style #
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

#===================================================================================#
# Run as root btw #
echo
if [ "$UID" -ne "$ROOT_UID" ]
then
    echo -e ${root_required[$LANGAGE]}
    echo
    exit $E_NOTROOT
else
    echo -e ${root_access[$LANGAGE]}
    echo
fi

#===================================================================================#
# just for output style #
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

#===================================================================================#
# Start update linux #
echo
echo -e ${check_update[$LANGAGE]}
apt update
echo -e ${done_update[$LANGAGE]}
echo
echo -e ${check_upgrade[$LANGAGE]}
apt -y upgrade --auto-remove --purge
echo -e ${done_upgrade[$LANGAGE]}
echo
echo -e ${check_upgradedist[$LANGAGE]}
apt -y dist-upgrade --auto-remove --purge
echo -e ${done_upgradedist[$LANGAGE]}
echo

#===================================================================================#
# Start install required package for steamcmd #
echo
echo -e ${install_curl[$LANGAGE]}
apt -y install curl
echo -e ${done_curl[$LANGAGE]}
echo
echo -e ${install_nano[$LANGAGE]}
apt -y install nano
echo -e ${done_nano[$LANGAGE]}
echo
echo -e ${install_openssl[$LANGAGE]}
apt -y install openssl
echo -e ${done_openssl[$LANGAGE]}
echo