#!/bin/bash

# Get the weather data from the API
source "./lib.sh"

# Get the city from the user
# If no city is given, use METEO_CITY or Yaounde
city="${1:-${METEO_CITY:-Yaounde}}"

# Replace spaces in the city name with plus signs
city_url="${city// /+}"

# Creating the weather API link
url="https://wttr.in/${city_url}?format=j1"

# Abstracting the weather data from the API
data=$(curl_json "$url") || die "Could not connect to the weather service." 1

# temperature from the weather data
temperature=$(echo "$data" | jq -r '.current_condition[0].temp_C')

# Get the weather description
description=$(echo "$data" | jq -r '.current_condition[0].weatherDesc[0].value')

# humidity from the weather data
humidity=$(echo "$data" | jq -r '.current_condition[0].humidity')

# Show the weather information to the user
echo "$city: ${temperature}°C, $description, humidity ${humidity}%"
