#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <hosts_file>"
    exit 1
fi

HOSTS_FILE="$1"

if [ ! -f "$HOSTS_FILE" ]; then
    echo "File does not exist!"
    exit 1
fi

verify-IP() {
    ip="$1"
    name="$2"

    if nslookup "$name" | grep -qw "$ip"; then
        return 0
    else
        echo "Bogus IP for $name in $HOSTS_FILE!"
        return 1
    fi
}

while IFS=' ' read -r ip name
do
    echo "IP: [$ip]"
    echo "Name: [$name]"

    verify-IP "$ip" "$name"

done < "$HOSTS_FILE"
