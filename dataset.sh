#!/bin/bash

ZIP_URL="https://phm-datasets.s3.amazonaws.com/NASA/5.+Battery+Data+Set.zip"

DEST_FOLDER="battery_dataset"

wget "$ZIP_URL" -O /tmp/downloaded_file.zip


mkdir -p "$DEST_FOLDER"

unzip /tmp/downloaded_file.zip -d "$DEST_FOLDER"

extract_nested_zip() {
    local zip_file="$1"
    local dest_folder="$2"

    unzip "$zip_file" -d "$dest_folder"

    rm "$zip_file"
}

while IFS= read -r -d '' zip_file; do
    extract_nested_zip "$zip_file" "${zip_file%.*}"
done < <(find "$DEST_FOLDER" -type f -name "*.zip" -print0)

find "$DEST_FOLDER" -type f -name "*.zip" -exec rm {} +

echo "Extraction and cleanup completed."