### 1. Clone dự án:

```bash
git clone https://github.com/JxNov/matrix-server-template.git
cd matrix-server-template
```

### 2. Cấu hình tên miền:

- Cấu hình tên miền: Sao chép `.env.example` thành `.env` và chỉnh sửa biến `DOMAIN` thành tên miền của bạn, thêm biến `CF_TOKEN` nếu bạn sử dụng Cloudflare.

### 3. Cài đặt SSL:

```bash
chmod +x generate-and-start.sh
./generate-and-start.sh
```
