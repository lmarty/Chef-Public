#!/bin/bash
if [ -z $1 ] ; then
  echo "usage: $0 FQDN"
  exit 1
fi

openssl genrsa -des3 -passout pass:temporary -out $1.tmp
openssl rsa -passin pass:temporary -in $1.tmp -out $1.key
rm $1.tmp
openssl req -new -key $1.key -out $1.csr

cat $1.csr

echo "Save the resulting certificate as $1.cer"
