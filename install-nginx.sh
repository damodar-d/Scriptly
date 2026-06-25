#!bin/bash

set -e

sudo apt update
sudo apt upgrade -y

sudo apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring

sudo install -m 0755 -d /etc/apt/keyrings

curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
https://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list

sudo apt update
sudo apt install nginx