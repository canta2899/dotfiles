#!/bin/sh

# Produces a JWT from a given json containing
# {
#   header: {
#       your jwt header 
#   },
#   body: {
#       your jwt body
#   }
# }
# Or decodes from a given one
# 
# encode -> cat your_json.json | jwt encode mysecret
# decode -> printf your_jwt    | jwt decode mysecret

apply_padding() {
    l=$((${#1} % 4))

    if [ $l -eq 2 ]; then printf "$1"'=='
    elif [ $l -eq 3 ]; then printf "$1"'='
    else printf "$1"; fi
}

read -d '' content

if [[ $# -lt 1 ]]; then
    printf "Provide encode or decode command and secret\n"
    exit 1
fi

CMD=$1

if [ $CMD == "encode" ]; then
    b64header=$(echo $content | jq -Mrc .header | tr -d '\n'| basenc --base64url | tr -d '=')
    b64body=$(echo $content | jq -Mrc .body | tr -d '\n' | basenc --base64url | tr -d '=')
    secret=$2
    signature=$(printf "$b64header.$b64body" | openssl dgst -binary -sha256 -hmac $secret | basenc --base64url | tr -d '=')

    printf "$b64header.$b64body.$signature\n"
fi

if [ $CMD == "decode" ]; then
    real_header=$(printf $content | cut -d '.' -f 1)
    real_body=$(printf $content | cut -d '.' -f 2)
    real_secret=$2

    header=$(apply_padding $real_header)
    body=$(apply_padding $real_body)
    secret=$(printf $content | cut -d "." -f 3)

    computed_signature=$(printf "$real_header.$real_body" | openssl dgst -binary -sha256 -hmac $real_secret | basenc --base64url | tr -d '=')

    if [ $computed_signature != $secret ]; then
        printf "JWT is not valid\n"
        exit 1
    fi

    printf $header | basenc -d --base64url | tr -d '=' | jq .
    printf $body | basenc -d --base64url | tr -d '=' | jq .
fi

