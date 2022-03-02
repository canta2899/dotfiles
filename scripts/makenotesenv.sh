#!/bin/sh

# Builds a "notes" directory template (with makefile) ready to take markdown notes

if [ -d "notes" ]; 
then
    echo "notes directory already exists"
    return 1
fi
mkdir -p notes

cat <<-'EOF' > notes/Makefile
DIRNAME := pdfs

MDFOLDER = ./

MARKDOWNS := $(wildcard $(MDFOLDER)/*.md)

# PDFS=$(MARKDOWNS:.md=.pdf)

SOURCES := $(patsubst %.md,%.pdf,$(subst $(MDFOLDER),$(DIRNAME),$(MARKDOWNS)))

$(DIRNAME)/%.pdf: $(MDFOLDER)/%.md
    @echo "Building $@..."
    @pandoc -f markdown-implicit_figures $^ -o $@

.PHONY : all

all: $(SOURCES)
EOF

mkdir -p notes/img
mkdir -p notes/pdfs


