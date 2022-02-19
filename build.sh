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

# LINK the different object files
rgblink -d                      `# DMG mode` \
        -t                      `# tiny ROM (32 KB)` \
        -m bin/${ROM_FILE_NAME}.map  `# map output file` \
        -n bin/${ROM_FILE_NAME}.sym  `# symbols output file (debugging purpose)` \
        -o bin/${ROM_FILE_NAME}.gb   `# ROM output file` \
        bin/home.o              `# object files` \
        bin/wram.o

# FIX the ROM with different options, checksums and Nintendo Logo
rgbfix -j                   `# non-japanese version` \
       -v                   `# validate ROM (checksums and Nintendo Logo)` \
       -n 0                 `# game version number` \
       -k 01                `# new license code` \
       -l 0x33              `# old license code. Should be 0x33 when used new license code for SGB compatibility` \
       -m 0                 `# MBC controller type` \
       -r 0                 `# RAM size` \
       -t "${ROM_TITLE}"    `# ROM title` \
       bin/${ROM_FILE_NAME}.gb   `# ROM to fix` 

echo
echo "${ROM_FILE_NAME}.gb generated successfully!"
set +e
