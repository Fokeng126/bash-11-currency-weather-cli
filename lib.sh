#!/bin/bash

die() {
    echo "Error: $1" >&2
    exit "$2"
}

curl_json() {
    curl -fsS --max-time 10 "$1" 2>/dev/null
}
