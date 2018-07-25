#!/bin/bash

rpms=( ansible-2.4.2 git python python-devel python2-pip openssl )
user=ansible
GREEN='\e[92m'
RED='\e[91m'
NC='\033[0m'
BLUE='\e[34m'

function if_rpm_installed()
{
	if (($(rpm -aq | grep -i $rpmI | wc -l ) > 0 ))
	then
		rpm_status=1
		echo -e ${GREEN}"The $rpmI is allready installed"${NC}
	else
		rpm_status=0
		echo -e ${RED}"The $rpmI is not installed, We'll install for you"${NC}
		install_rpm
	fi
}

function install_rpm()
{
	yum install $rpmI
}
function add_user()
{
if [ $(id -u) -eq 0 ]; then
	egrep $user /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo -e ${GREEN}"$user user already exists!"${NC}
		exit 1
	else
	        echo -e ${BLUE}"Please Enter password for $user user : "${NC}
		read password
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $user
		[ $? -eq 0 ] && echo -e ${GREEN}"User $user has been added to system!"${NC} || echo -e ${RED}"Failed to add a $user user!"${NC}
	fi
else
	echo -e ${RED}"You are not root"${NC}
	exit 2
fi
}
function main()
{
	for rpmI in "${rpms[@]}"
	do
		echo $rpmI
		if_rpm_installed
	done

	add_user
}
main
