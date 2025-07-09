#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
  echo "Usage: ./certbot-auto.sh your.domain.com"
  exit 1
fi

sudo apt update
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d $DOMAIN
