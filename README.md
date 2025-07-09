### 1. Clone dự án:

```bash
git clone https://github.com/JxNov/matrix-server-template.git
cd matrix-server-template
```

### 2. Cấu hình tên miền:

- Cấu hình tên miền: Sao chép `.env.example` thành `.env` và chỉnh sửa biến `DOMAIN` thành tên miền của bạn.

### 3. Khởi động dịch vụ:

```bash
docker compose up -d
```

### 4. Cài đặt SSL:

```bash
chmod +x certbot-auto.sh
./certbot-auto.sh your.domain.com
```
