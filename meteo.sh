#!/bin/bash

source "./lib.sh"

city="${1:-${METEO_CITY:-Yaounde}}"

city_url="${city// /+}"

url="https://wttr.in/${city_url}?format=j1"

data=$(curl_json "$url") || die "Could not connect to the weather service." 1

temperature=$(echo "$data" | jq -r '.current_condition[0].temp_C')
description=$(echo "$data" | jq -r '.current_condition[0].weatherDesc[0].value')
humidity=$(echo "$data" | jq -r '.current_condition[0].humidity')

echo "$city: ${temperature}°C, $description, humidity ${humidity}%"
