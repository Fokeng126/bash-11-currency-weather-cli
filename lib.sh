#!/bin/bash

# This will display an error message and stop the script
die() {
    echo "Error: $1" >&2
    exit "$2"
}

# Get JSON data from an API using curl
curl_json() {
    curl -fsS --max-time 10 "$1" 2>/dev/null
}
