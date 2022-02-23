#!/bin/bash

# exit when any command fails
set -e

# prepare binaries directory
if [ ! -d "bin" ]
then
    mkdir bin
else
    yes | rm -rf bin/* > /dev/null
fi

# ROM title and output ROM file name
ROM_FILE_NAME=$1
ROM_TITLE=$2

# BUILD generates object files from assambly code
rgbasm -o bin/wram.o wram.asm
rgbasm -o bin/home.o home.asm
rgbasm -o bin/main.o main.asm

# LINK the different object files
rgblink -d                      `# DMG mode` \
        -p 0xff                 `# pad value between sections` \
        -m bin/${ROM_FILE_NAME}.map  `# map output file` \
        -n bin/${ROM_FILE_NAME}.sym  `# symbols output file (debugging purpose)` \
        -l layout.link               `# sections layout file` \
        -o bin/${ROM_FILE_NAME}.gb   `# ROM output file` \
        bin/home.o              `# object files` \
        bin/wram.o \
        bin/main.o

# FIX the ROM with different options, checksums and Nintendo Logo
rgbfix -j                   `# non-japanese version` \
       -v                   `# validate ROM (checksums and Nintendo Logo)` \
       -n 0                 `# game version number` \
       -k 11                `# new license code` \
       -l 0x33              `# old license code. Should be 0x33 when used new license code for SGB compatibility` \
       -p 0xff              `# pad value for rom size alignement` \
       -m 0x13              `# MBC controller type` \
       -r 03                `# RAM size` \
       -t "${ROM_TITLE}"    `# ROM title` \
       bin/${ROM_FILE_NAME}.gb   `# ROM to fix` 

echo
echo "${ROM_FILE_NAME}.gb generated successfully!"
set +e
