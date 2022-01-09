#!/bin/sh

# Performs a batch conversion to 24 bit of all the 
# wav files inside the current folder using sox

# The output files are places inside the 24bit folder

mkdir -p 24bit

for audio in *.wav
do
	sox "$audio" -b 24 "24bit/${audio%.wav}_24bit.wav"
done
