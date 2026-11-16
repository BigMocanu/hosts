#!/bin/bash

verify-IP() {
    ip="$1"
    name="$2"

    if nslookup "$name" | grep -qw "$ip"; then
        return 0
    else
        echo "Bogus IP for $name in $HOME/etc/hosts!"
        return 1
    fi
}


while IFS=' ' read -r ip name
do
    echo "IP: [$ip]"
    echo "Name: [$name]"

    verify-IP "$ip" "$name"

done < "$HOME/etc/hosts"
