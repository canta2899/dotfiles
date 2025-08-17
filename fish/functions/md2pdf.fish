function md2pdf
    if test (count $argv) -eq 1
        set in $argv[1]
        pandoc -f markdown -t latex "$in" -o (string replace -r '\.md$' '.tex' -- "$in") -s --number-sections
        and pdflatex (string replace -r '\.md$' '.tex' -- "$in")
        and rm (string replace -r '\.md$' '.tex' -- "$in") (string replace -r '\.md$' '.aux' -- "$in") (string replace -r '\.md$' '.log' -- "$in")
    else
        echo 'Usage: md2pdf input.md'
    end
end

