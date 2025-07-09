#!/bin/bash
set -e

# Load ENV
source ./config.env

if [[ -z "$DOMAIN" || -z "$CF_TOKEN" ]]; then
  echo "❌ Thiếu DOMAIN hoặc CF_TOKEN trong config.env"
  exit 1
fi

echo "🔧 Tạo cấu hình Synapse cho domain: $DOMAIN"
mkdir -p data

docker run -it --rm \
  -v "$(pwd)/data:/data" \
  -e SYNAPSE_SERVER_NAME=$DOMAIN \
  -e SYNAPSE_REPORT_STATS=yes \
  matrixdotorg/synapse:latest \
  generate

echo "🔐 Ghi thông tin Cloudflare DNS token"
mkdir -p certbot
cat <<EOF > ./certbot/cloudflare.ini
dns_cloudflare_api_token = $CF_TOKEN
EOF
chmod 600 ./certbot/cloudflare.ini

echo "📜 Cấp SSL từ Let's Encrypt (DNS-01)..."
sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials ./certbot/cloudflare.ini \
  -d $DOMAIN

echo "🛠️ Cập nhật nginx config với domain: $DOMAIN"
sed -i "s/server_name .*/server_name $DOMAIN;/" ./nginx/matrix.nginx.conf
sed -i "s|live/.*fullchain.pem|live/$DOMAIN/fullchain.pem|" ./nginx/matrix.nginx.conf
sed -i "s|live/.*privkey.pem|live/$DOMAIN/privkey.pem|" ./nginx/matrix.nginx.conf

echo "🚀 Khởi động Docker Compose"
docker compose up -d

echo "✅ Hoàn tất! Kiểm tra Federation:"
echo "curl https://$DOMAIN:8448/_matrix/key/v2/server"
