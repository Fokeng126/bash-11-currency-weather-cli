#!/bin/bash

# Load the shared helper functions from lib.sh
source "./lib.sh"

# The values given by the user
amount="$1"
from="$2"
to="$3"

# Checking if the user gave exactly 3 arguments
if [ "$#" -ne 3 ]; then
    die "Usage: ./fx.sh AMOUNT FROM TO" 2
fi

# Checking if the amount is a valid positive number
if ! [[ "$amount" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    die "Amount must be a positive number." 2
fi

# Making sure the amount is greater than 0
if ! awk "BEGIN {exit !($amount > 0)}"; then
    die "Amount must be greater than 0." 2
fi

# Changing the currency codes to uppercase
from=$(echo "$from" | tr '[:lower:]' '[:upper:]')
to=$(echo "$to" | tr '[:lower:]' '[:upper:]')

# Checking both currency codes have exactly 3 letters
if ! [[ "$from" =~ ^[A-Z]{3}$ ]] || ! [[ "$to" =~ ^[A-Z]{3}$ ]]; then
    die "Currency codes must contain exactly 3 letters." 2
fi

# Creating the API link using the source currency
url="https://open.er-api.com/v6/latest/$from"

# Get the exchange rate data from the API
data=$(curl_json "$url") || die "Could not connect to the exchange rate service." 1

# Checking if the API request was successful
result=$(echo "$data" | jq -r '.result')

if [ "$result" != "success" ]; then
    die "Could not get exchange rates." 1
fi

# Get the exchange rate for the target currency
rate=$(echo "$data" | jq -r --arg currency "$to" '.rates[$currency]')

# Checking if the target currency exists
if [ "$rate" = "null" ]; then
    die "Unknown currency: $to" 2
fi

# Calculate the converted amount and show 2 decimal places
converted=$(awk "BEGIN {printf \"%.2f\", $amount * $rate}")

# Display the final conversion result
echo "$amount $from = $converted $to   (rate $rate)"
