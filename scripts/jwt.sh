#!/bin/sh

# Produces a JWT from a given json containing
# {
#   header: {
#       your jwt header 
#   },
#   body: {
#       your jwt body
#   },
#   secret: your jwt secret
# }

# make your json and then do the following 
# cat myjson.json | sh jwt.sh

read -d '' content

b64header=$(echo $content | jq -Mrc .header | tr -d '\n'| base64 | tr '/+' '_-' | tr -d '=')
b64body=$(echo $content | jq -Mrc .body | tr -d '\n' | base64 | tr '/+' '_-' | tr -d '=')
secret=$(echo $content | jq -Mrc .secret | tr -d '\n')
signature=$(printf "$b64header.$b64body" | openssl dgst -binary -sha256 -hmac $secret | base64 | tr '/+' '_-' | tr -d '=')

printf "$b64header.$b64body.$signature\n"

