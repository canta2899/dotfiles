function makepdf
    if test (count $argv) -eq 1
        pandoc -f markdown-implicit_figures --number-sections $argv[1] -o (string replace -r '\.md$' '.pdf' -- $argv[1])
    else
        echo 'Usage: makepdf /path/to/markdown'
    end
end

