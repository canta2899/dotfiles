function b64url
    # Read a single line from stdin, URL-safe base64 encode (no padding)
    read -l content
    printf '%s' $content | base64 | tr '/+' '_-' | tr -d '='
end

