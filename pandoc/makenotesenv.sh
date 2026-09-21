#!/bin/bash

# Builds a "notes" directory template (with makefile) ready to take markdown notes

SEDCMD="sed"
OS=$(uname)
NOTES=${1:-"notes"}
MKF="$NOTES/Makefile"
PDFS="$NOTES/pdfs"
IMG="$NOTES/img"
EISGOVEL_URI="https://github.com/Wandmalfarbe/pandoc-latex-template"

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

echo "Choose Template"
TEMPLATE=`printf "Raw\nEisgovel\n" | fzf`

if [ "$TEMPLATE" = 'Raw' ]; then
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
else

cat <<'EOF' > $MKF
DIRNAME := pdfs
MDFOLDER = ./
MARKDOWNS := $(wildcard $(MDFOLDER)/*.md)
SOURCES := $(patsubst %.md,%.pdf,$(subst $(MDFOLDER),$(DIRNAME),$(MARKDOWNS)))

$(DIRNAME)/%.pdf: $(MDFOLDER)/%.md
	@echo "Building $@..."
	@pandoc 											      \
		--from markdown-implicit_figures  \
		--template eisvogel 				      \
		--listings 									      \
		-V babel=italian 						      \
		$^ 													      \
		-o $@

.PHONY : all

all: $(SOURCES)
EOF
fi


$SEDCMD -i 's/    /\t/g' $MKF

echo "notes workspace created"

[ "$TEMPLATE" = 'Eisgovel' ] && printf "Ensure eisgovel is installed\n%s\n" "$EISGOVEL_URI"
