#!/bin/bash

source "./lib.sh"

amount="$1"
from="$2"
to="$3"

if [ "$#" -ne 3 ]; then
    die "Usage: ./fx.sh AMOUNT FROM TO" 2
fi

 if ! [[ "$amount" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    die "Amount must be a positive number." 2
fi

if ! awk "BEGIN {exit !($amount > 0)}"; then
    die "Amount must be greater than 0." 2
fi

from=$(echo "$from" | tr '[:lower:]' '[:upper:]')
to=$(echo "$to" | tr '[:lower:]' '[:upper:]')

if ! [[ "$from" =~ ^[A-Z]{3}$ ]] || ! [[ "$to" =~ ^[A-Z]{3}$ ]]; then
    die "Currency codes must contain exactly 3 letters." 2
fi
url="https://open.er-api.com/v6/latest/$from"

data=$(curl_json "$url") || die "Could not connect to the exchange rate service." 1

result=$(echo "$data" | jq -r '.result')

if [ "$result" != "success" ]; then
    die "Could not get exchange rates." 1
fi

rate=$(echo "$data" | jq -r --arg currency "$to" '.rates[$currency]')

if [ "$rate" = "null" ]; then
    die "Unknown currency: $to" 2
fi

converted=$(awk "BEGIN {printf \"%.2f\", $amount * $rate}")

echo "$amount $from = $converted $to   (rate $rate)"
