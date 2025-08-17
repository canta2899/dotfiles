function topdf
    if test (count $argv) -eq 1
        pandoc -o (string replace -r '\.md$' '.pdf' -- $argv[1]) $argv[1] --template eisvogel
    else
        echo 'Usage: topdf markdown_document.md'
    end
end

