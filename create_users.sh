#!/bin/bash

set -e

names_file="names.txt"
password="25qw5erty_"

while read -r line; do
        echo -e "-------------"
        adduser --create-home ${line}
        echo "${line}:${password}" | chpasswd

        echo -e "Add ${line} to wheel group"
        usermod -aG wheel ${line}

        touch /etc/sudoers.d/${line}

        echo -e "Add ${line} to sudoers"
        cat > /etc/sudoers.d/${line} << EOF
${line} ALL=(ALL:ALL)   ALL
EOF

        echo -e "User ${line} successfully created!"
        echo -e "-------------"
done < "$names_file"