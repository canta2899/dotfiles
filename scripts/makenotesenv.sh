#!/bin/sh

# Builds a "notes" directory template (with makefile) ready to take markdown notes

SEDCMD="sed"
OS=$(uname)
NOTES="notes"
MKF="$NOTES/Makefile"
PDFS="$NOTES/pdfs"
IMG="$NOTES/img"

if [ -d "$NOTES" ]; 
then
    echo "notes directory already exists"
    return 1
fi


[ "$OS" = 'Darwin' ] && SEDCMD=gsed

mkdir -p $NOTES
mkdir -p $IMG
mkdir -p $PDFS
echo "pdfs" > $NOTES/.gitignore

cat <<'EOF' > $MKF
DIRNAME := pdfs

MDFOLDER = ./

MARKDOWNS := $(wildcard $(MDFOLDER)/*.md)

# PDFS=$(MARKDOWNS:.md=.pdf)

SOURCES := $(patsubst %.md,%.pdf,$(subst $(MDFOLDER),$(DIRNAME),$(MARKDOWNS)))

$(DIRNAME)/%.pdf: $(MDFOLDER)/%.md
    @echo "Building $@..."
    @pandoc \
        -f markdown-implicit_figures \
        $^ \
        -V geometry:margin=0.8in \
		-V colorlinks=true \
		-V linkcolor=blue \
		-V urlcolor=blue \
		-V babel=italian \
		-V asmmath \
		-o $@

.PHONY : all

all: $(SOURCES)
EOF

$SEDCMD -i 's/    /\t/g' $MKF

echo "notes workspace created"
