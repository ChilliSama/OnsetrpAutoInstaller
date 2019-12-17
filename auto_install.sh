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
LANGUAGE=1     # [FR]LANGUAGE=0 , [EN]LANGUAGE=1
ERROR=1        # Exit with error status
SUCCESS=0      # Exit with success status
CH='[a-zA-Z]'  # Character range in ascii to compare it 
INT='^[0-9]+$' # Integer range in ascii to compare it
USERTMP="tmp_user"
PSWD="tmp_password"

# Translation - ${exemple[0]} to french #
declare -a root_required=("\e[7mVous devez être en root pour lancer le scrip.\e[0m" "\e[7mMust be root to run this script.\e[0m")
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
declare -a request_curl=("Voulez vous installer Curl ? [o/n] : " "Do you want to install Curl ? [y/n] : ")
declare -a request_nano=("Voulez vous installer Nano ? [o/n] : " "Do you want to install Nano ? [y/n] : ")
declare -a request_openssl=("Voulez vous installer Openssl ? [o/n] : " "Do you want to install Openssl ? [y/n] : ")
declare -a awnser_trad=('[o-on-en]' '[y-yn-en]')
declare -a remake_read=("Veuillez écrire [o]ui ou [n]on -> [o/n] : " "Please write [y]es ou [n]ot -> [y/n] : ")
declare -a error_read=("Veuillez relancer le scrip en étant sur de bien répondre aux questions." "Please run the script again and make sure to correctly awnser to the question.")
declare -a request_steamcmd=("Voulez vous installer Steamcmd et Onset ? [o/n] : " "Do you want to install Steamcmd and Onset ? [y/n] : ")
declare -a install_gcc=("\e[7mInstallation de GCC [3/3]...\e[0m" "\e[7mGCC instalation [3/3]...\e[0m")
declare -a done_gcc=("\e[7mStatut de GCC : \e[32mInstallé\e[0m" "\e[7mGCC status : \e[32mInstalled\e[0m")
declare -a install_sudo=("\e[7mInstallation de Sudo [3/3]...\e[0m" "\e[7mSudo instalation [3/3]...\e[0m")
declare -a done_sudo=("\e[7mStatut de Sudo : \e[32mInstallé\e[0m" "\e[7mSudo status : \e[32mInstalled\e[0m")
declare -a user_create=("\e[92m    C\e[0mreation d'un nouvelle utilisateur temporaire.\e[0m" "\e[92m    C\e[0mreation of temporary user.\e[0m")
declare -a user_delete=("\e[92m    S\e[0mupression de l'utilisateur temporaire.\e[0m" "\e[92m    D\e[0meleting temporary user.\e[0m")

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
read -p "Write the number here : " check_r
echo

if ! [[ "$check_r" =~ $INT ]]
then
    read -p "[$check_r] is not a number, please select a language under the list : " check_r
    echo
    if ! [[ "$check_r" =~ $INT ]]
    then
        echo "[$check_r] is not a number, run again the script and select a language under the list please !"
        exit $ERROR
    elif [$check_r -ne 0 -o $check_r -ne 1]
    then
        read -p "[$check_r] are not on the list, please select a language under the list : " check_r
        echo
        if [-z "$check_r"]
        then
            echo "[$check_r] are not on the list, run again the script and select a language under the list please !"
            exit $ERROR
        fi
    fi
fi
if [ $check_r -eq 1 ]
then
    LANGUAGE=1
elif [ $check_r -eq 0 ]
then
    LANGUAGE=0
fi
echo "Language set to : ${p_language[$LANGUAGE]}"

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
    echo -e ${root_required[$LANGUAGE]}
    echo
    exit $E_NOTROOT
else
    echo -e ${root_access[$LANGUAGE]}
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
echo -e ${check_update[$LANGUAGE]}
apt update
echo -e ${done_update[$LANGUAGE]}
echo
echo -e ${check_upgrade[$LANGUAGE]}
apt -y upgrade --auto-remove --purge
echo -e ${done_upgrade[$LANGUAGE]}
echo
echo -e ${check_upgradedist[$LANGUAGE]}
apt -y dist-upgrade --auto-remove --purge
echo -e ${done_upgradedist[$LANGUAGE]}
echo

#===================================================================================#
# Start install required package for steamcmd #
# Curl #
echo
echo -en ${request_curl[$LANGUAGE]}
read check_r
if ! [[ "$check_r" =~ $CH ]]
then
    echo -en ${remake_read[$LANGUAGE]}
    read check_r
    echo
    if ! [[ "$check_r" =~ $CH ]]
    then
        echo ${error_read[$LANGUAGE]}
        exit $ERROR
    elif [["$check_r" =~ ${awnser_trad[$LANGUAGE]}]]
    then
        echo -en ${remake_read[$LANGUAGE]}
        read check_r
        echo
        if [["$check_r" =~ ${awnser_trad[$LANGUAGE]}]]
        then
            echo ${error_read[$LANGUAGE]}
            exit $ERROR
        fi
    fi
fi
if [ "$check_r" == "o" ]
then
    echo -e ${install_curl[$LANGUAGE]}
    apt -y install curl
    echo -e ${done_curl[$LANGUAGE]}
    echo
elif [ "$check_r" != "n" ]
then
    echo -en ${remake_read[$LANGUAGE]}
    read check_r
    echo
    if [ "$check_r" == "o" ]
    then
        echo -e ${install_curl[$LANGUAGE]}
        apt -y install curl
        echo -e ${done_curl[$LANGUAGE]}
        echo
    else
        echo ${error_read[$LANGUAGE]}
        exit $ERROR
    fi
fi
# Nano #
echo
echo -en ${request_nano[$LANGUAGE]}
read check_r
if ! [[ "$check_r" =~ $CH ]]
then
    echo -en ${remake_read[$LANGUAGE]}
    read check_r
    echo
    if ! [[ "$check_r" =~ $CH ]]
    then
        echo ${error_read[$LANGUAGE]}
        exit $ERROR
    elif [["$check_r" =~ ${awnser_trad[$LANGUAGE]}]]
    then
        echo -en ${remake_read[$LANGUAGE]}
        read check_r
        echo
        if [["$check_r" =~ ${awnser_trad[$LANGUAGE]}]]
        then
            echo ${error_read[$LANGUAGE]}
            exit $ERROR
        fi
    fi
fi
if [ "$check_r" == "o" ]
then
    echo -e ${install_nano[$LANGUAGE]}
    apt -y install nano
    echo -e ${done_nano[$LANGUAGE]}
    echo
elif [ "$check_r" != "n" ]
then
    echo -en ${remake_read[$LANGUAGE]}
    read check_r
    echo
    if [ "$check_r" == "o" ]
    then
        echo -e ${install_nano[$LANGUAGE]}
        apt -y install nano
        echo -e ${done_nano[$LANGUAGE]}
        echo
    else
        echo ${error_read[$LANGUAGE]}
        exit $ERROR
    fi
fi
# Openssl #
echo
echo -en ${request_openssl[$LANGUAGE]}
read check_r
if ! [[ "$check_r" =~ $CH ]]
then
    echo -en ${remake_read[$LANGUAGE]}
    read check_r
    echo
    if ! [[ "$check_r" =~ $CH ]]
    then
        echo ${error_read[$LANGUAGE]}
        exit $ERROR
    elif [["$check_r" =~ ${awnser_trad[$LANGUAGE]}]]
    then
        echo -en ${remake_read[$LANGUAGE]}
        read check_r
        echo
        if [["$check_r" =~ ${awnser_trad[$LANGUAGE]}]]
        then
            echo ${error_read[$LANGUAGE]}
            exit $ERROR
        fi
    fi
fi
if [ "$check_r" == "o" ]
then
    echo -e ${install_openssl[$LANGUAGE]}
    apt -y install openssl
    echo -e ${done_openssl[$LANGUAGE]}
    echo
elif [ "$check_r" != "n" ]
then
    echo -en ${remake_read[$LANGUAGE]}
    read check_r
    echo
    if [ "$check_r" == "o" ]
    then
        echo -e ${install_openssl[$LANGUAGE]}
        apt -y install openssl
        echo -e ${done_openssl[$LANGUAGE]}
        echo
    else
        echo ${error_read[$LANGUAGE]}
        exit $ERROR
    fi
fi

#===================================================================================#
# Steamcmd #
echo
echo -en ${request_steamcmd[$LANGUAGE]}
read check_r
if ! [[ "$check_r" =~ $CH ]]
then
    echo -en ${remake_read[$LANGUAGE]}
    read check_r
    echo
    if ! [[ "$check_r" =~ $CH ]]
    then
        echo ${error_read[$LANGUAGE]}
        exit $ERROR
    elif [["$check_r" =~ ${awnser_trad[$LANGUAGE]}]]
    then
        echo -en ${remake_read[$LANGUAGE]}
        read check_r
        echo
        if [["$check_r" =~ ${awnser_trad[$LANGUAGE]}]]
        then
            echo ${error_read[$LANGUAGE]}
            exit $ERROR
        fi
    fi
fi
if [ "$check_r" == "o" ]
then
    echo -e ${install_gcc[$LANGUAGE]}
    apt-get -y install lib32gcc1
    echo -e ${done_gcc[$LANGUAGE]}
    echo
    echo -e ${install_sudo[$LANGUAGE]}
    apt-get -y install sudo
    echo -e ${done_sudo[$LANGUAGE]}
    echo
    clear
    #===================================================================================#
    # Create sudo user #
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
    
    echo
    echo -e ${user_create[$LANGUAGE]}
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

    sleep 4
    adduser --disabled-password --no-create-home --gecos "" $USERTMP
    usermod -aG sudo $USERTMP
    echo -n "coucou" | sudo -u "root" deluser $USERTMP  - delet tmp user

    #===================================================================================#

elif [ "$check_r" != "n" ]
then
    echo ${error_read[$LANGUAGE]}
    exit $ERROR
fi

#echo -n "pswd" | sudo -u "root" deluser $USERTMP  - delet tmp user