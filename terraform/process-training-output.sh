#!/bin/bash
if (( $# > 0 )); then
	DOMAIN="-$1";
fi

ips="$(terraform output -json | jq -r '."training_ips'$DOMAIN'".value[0][]')"
passwords="$(terraform output -json | jq -r '."training_pws'$DOMAIN'".value[0][]')"
dns="$(terraform output -json | jq -r '."training_dns'$DOMAIN'".value[0][]')"
lines=$(echo "$ips" | wc -l)
user="$(yes ubuntu | head -n $lines)"

paste <(echo "$user") <(echo "$ips") <(echo "$dns") <(echo "$passwords")
