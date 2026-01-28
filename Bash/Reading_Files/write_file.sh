#!/bin/bash

function write_to_file() {
    local file_path="$1"
    local data="$2"

    echo "$data" >> "$file_path"

}

write_to_file "./track.txt" "Rajea is writing Bash scripts"