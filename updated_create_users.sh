#!/bin/bash

password="qwerty123="

function addUser()
{
	if id $1 &>/dev/null; then
		echo "Skipping... User $1 already exists!"
	else
		echo "Add user $1"
		adduser --create-home --shell /bin/bash $1
	fi
}

function chUserGroup()
{
	echo "Add user $1 to 'wheel' group"
	usermod -aG wheel $1
}

function setPasswd()
{
	echo "Setting standart password; Maximum days - 10"
	echo "$1:${password}" | chpasswd
	chage -M 10 $1
}

function addToSudoers()
{
	echo "Add file $1 with access to sudoers.d"
	touch /etc/sudoers.d/$1
	echo "$1	ALL=(ALL:ALL)	ALL" > /etc/sudoers.d/$1
	chmod 0440 /etc/sudoers.d/$1
}

if [[ ! -f users ]]; then
    echo "File \"users\" not found!"
    exit 1
fi

while read -r line; do
	echo "----------------------------------------------"
	addUser ${line}
	chUserGroup ${line}
	setPasswd ${line}
	addToSudoers ${line}
	echo "User ${line} successfully created!"
	echo "----------------------------------------------"
done < ./users
