function md2slides
    if test (count $argv) -eq 1
        set in $argv[1]
        pandoc -s --webtex -i -t slidy "$in" -o (string replace -r '\.md$' '.html' -- "$in")
    else
        echo 'Usage: md2slides markdown_document.md'
    end
end

