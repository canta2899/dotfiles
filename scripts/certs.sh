# Not meant to be run but to be used as reference
# https://www.digicert.com/kb/ssl-support/openssl-quick-reference-guide.htm 

CERTS=./certificates              # certificates file folder
CA_CRT=$CERTS/rootCA.crt          # rootCA certificate file
CA_KEY=$CERTS/rootCA.key          # rootCA private key file 
DOMAIN_KEY=$CERTS/domain.key      # domain private key
DOMAIN_CSR=$CERTS/domain.csr      # domain certificate signing request
DOMAIN_EXT=./domain.ext           # domain ext file
DOMAIN_CRT=$CERTS/domain.crt      # domain certificate file

rm $CERTS/* > /dev/null 2>&1
mkdir -p $CERTS

# --- QUICK SELF SIGNED CERTIFICATE ---
SELF_SIGNED_KEY=$CERTS/selfsigned.key    # self signed certificate private key
SELF_SIGNED_KEY=$CERTS/selfsigned.crt    # self signed certificate file
openssl req -x509 -newkey rsa:4096 -keyout $SELF_SIGNED_KEY -out $SELF_SIGNED_CRT -sha256 -days 365

# 1. Creates a rsa:4096 key
# 2. Stores the key
# 3. Self signs a certificate with that key using sha256 for a 365 days duration

# -------------------------------------


# --- EXT FILE STRUCTURE --------------
cat <<EOF > $DOMAIN_EXT
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
EOF
# -------------------------------------


# --- CREATE ROOT CA ------------------
openssl genrsa -des3 -out $CA_KEY 2048
openssl req -x509 -new -nodes -sha256 -days 1825 -key $CA_KEY -out $CA_CRT
# -------------------------------------

# --- CSR GENERATION ------------------
openssl genrsa -out $DOMAIN_KEY 2048
openssl req -new -key $DOMAIN_KEY -out $DOMAIN_CSR
# -------------------------------------

# --- SIGNING CSR WITH ROOT CA --------
openssl x509 -req -in $DOMAIN_CSR -CA $CA_CRT -CAkey $CA_KEY -CAcreateserial -out $DOMAIN_CRT -days 825 -sha256 -extfile $DOMAIN_EXT
# -------------------------------------
