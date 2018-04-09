#!/bin/sh

#Developer certificate public private key decrypt
openssl aes-256-cbc -k "$IOS_CERT_SSL_KEY" -in scripts/certs/dev_private.enc -d -a -out scripts/certs/dev_private.p12
openssl aes-256-cbc -k "$IOS_CERT_SSL_KEY" -in scripts/certs/dev_public.enc -d -a -out scripts/certs/dev_public.cer

#Distribution certificate public private key decrypt
openssl aes-256-cbc -k "$IOS_CERT_SSL_KEY" -in scripts/certs/dist_private.enc -d -a -out scripts/certs/dist_private.p12
openssl aes-256-cbc -k "$IOS_CERT_SSL_KEY" -in scripts/certs/dist_public.enc -d -a -out scripts/certs/dist_public.cer

#Ad hoc mobileprovision
openssl aes-256-cbc -k "$IOS_CERT_SSL_KEY" -in scripts/certs/dev_mobileprovision.enc -d -a -out scripts/certs/dev.mobileprovision

#Ad hoc mobileprovision
openssl aes-256-cbc -k "$IOS_CERT_SSL_KEY" -in scripts/certs/adhoc_mobileprovision.enc -d -a -out scripts/certs/adhoc.mobileprovision

#Apple Worldwide Developer Relations Certificate
openssl aes-256-cbc -k "$IOS_CERT_SSL_KEY" -in scripts/certs/apple.enc -d -a -out scripts/certs/apple.cer