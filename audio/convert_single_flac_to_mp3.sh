#!/bin/bash

# This script converts FLAC audio files to high-quality MP3 files.
# The MP3 output is encoded with the highest audio quality (variable bitrate)
# and retains the metadata from the original file.

# ANSI color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Display heading
echo -e "${GREEN}"
echo "=============================================="
echo "      FLAC to MP3 Converter Script"
echo "=============================================="
echo -e "${NC}"
echo "This script converts FLAC files to MP3 with the highest audio quality."
echo "The converted MP3 will be saved in the same directory as the input file."
echo

if [[ $# -ne 1 ]]; then
	echo -e "${RED}Usage:${NC} $0 <audio_file.flac>"
	exit 1
fi

input_file="$1"
output_directory=$(dirname "$input_file")
file_name=$(basename "$input_file" .flac) # Remove the .flac extension

if [[ -f "$input_file" ]]; then
	echo -e "${YELLOW}Converting...${NC}"
	ffmpeg -i "$input_file" -q:a 0 -map_metadata 0 -id3v2_version 3 "${output_directory}/${file_name}.mp3" >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo -e "${GREEN}Conversion successful!${NC}"
	else
		echo -e "${RED}Conversion failed!${NC}"
	fi
else
	echo -e "${RED}File not found: $input_file${NC}"
	exit 1
fi
