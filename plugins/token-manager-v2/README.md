# Token Manager V2 Plugin

Plugin Kong untuk mengelola access token dan refresh token dengan penyimpanan Redis (Versi 2).

**🚀 Quick Start:** Lihat [QUICKSTART.md](./QUICKSTART.md) untuk mulai cepat!  
**🔗 Keycloak:** Lihat [KEYCLOAK_INTEGRATION.md](./KEYCLOAK_INTEGRATION.md) untuk integrasi Keycloak!

## 🆕 Perubahan dari Versi 1

### Perbaikan Kritis:
1. **✅ Fixed Infinite Loop** - Menghapus logika retry manual yang menyebabkan infinite loop
2. **✅ Fixed Query Parameter Auth** - Support penuh untuk autentikasi dengan query parameter (tanpa body)
3. **✅ Removed Problematic Function** - Menghapus fungsi `is_refresh_endpoint` yang menyebabkan plugin tidak bekerja
4. **✅ Simplified Retry Logic** - Client yang handle retry, bukan plugin
5. **✅ Better Error Handling** - Logging dan error handling yang lebih baik
6. **✅ Keycloak Compatible** - Fully compatible dengan keycloak-introspection plugin

## 🔗 Integrasi dengan Plugin Lain

### Keycloak Introspection
Plugin ini **FULLY COMPATIBLE** dengan `keycloak-introspection` plugin!

- Token Manager V2 inject token → Keycloak Introspection validate token
- Auto-refresh saat token expired
- Support semua Keycloak grant types

**📖 Lihat [KEYCLOAK_INTEGRATION.md](./KEYCLOAK_INTEGRATION.md) untuk panduan lengkap!**

## Fitur Utama

- ✅ Penyimpanan dan pengambilan token menggunakan Redis
- ✅ Refresh token otomatis saat menerima respons 401
- ✅ Support untuk JSON dan form-urlencoded content types
- ✅ Support untuk autentikasi dengan query parameter
- ✅ Substitusi token placeholder di header
- ✅ Manajemen token per-service menggunakan prefix

## Konfigurasi

### Field Konfigurasi:

| Field | Type | Required | Default | Deskripsi |
|-------|------|----------|---------|-----------|
| `access_token` | string | Ya | - | Access token untuk autentikasi |
| `refresh_token` | string | Tidak | - | Token untuk refresh access token |
| `refresh_endpoint` | string | Ya | - | URL endpoint untuk refresh token (bisa include query params) |
| `refresh_method` | string | Tidak | "POST" | HTTP method untuk request refresh |
| `refresh_body` | string | Tidak | - | Request body untuk refresh (kosongkan jika pakai query param) |
| `content_type` | string | Tidak | "application/json" | Content-Type header |
| `header_key` | string | Tidak | "Authorization" | Key header untuk token |
| `header_value` | string | Tidak | "Bearer $access_token" | Format value header (gunakan placeholder) |
| `ssl_verify` | boolean | Tidak | false | Enable/disable SSL verification |

### Konfigurasi Redis (Environment Variables):

| Variable | Default | Deskripsi |
|----------|---------|-----------|
| `REDIS_HOST` | "kong-redis" | Host Redis |
| `REDIS_PORT` | 6379 | Port Redis |
| `REDIS_TIMEOUT` | 1000 | Timeout koneksi (ms) |

## Contoh Penggunaan

### 1. Autentikasi dengan Query Parameter (Tanpa Body)

```bash
curl -X POST http://kong-admin:8001/services/my-service/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=initial_access_token" \
  --data "config.refresh_endpoint=http://auth-service/login?username=user&password=pass" \
  --data "config.refresh_method=POST" \
  --data "config.header_key=Authorization" \
  --data "config.header_value=Bearer \$access_token" \
  --data "config.ssl_verify=false"
```

### 2. Autentikasi dengan JSON Body

```bash
curl -X POST http://kong-admin:8001/services/my-service/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=initial_access_token" \
  --data "config.refresh_token=initial_refresh_token" \
  --data "config.refresh_endpoint=http://auth-service/refresh" \
  --data "config.refresh_method=POST" \
  --data 'config.refresh_body={"refresh_token": "$refresh_token"}' \
  --data "config.content_type=application/json" \
  --data "config.header_key=Authorization" \
  --data "config.header_value=Bearer \$access_token"
```

### 3. Autentikasi dengan Form-Urlencoded

```bash
curl -X POST http://kong-admin:8001/services/my-service/plugins \
  --data "name=token-manager-v2" \
  --data "config.access_token=initial_access_token" \
  --data "config.refresh_token=initial_refresh_token" \
  --data "config.refresh_endpoint=http://auth-service/refresh" \
  --data "config.refresh_method=POST" \
  --data "config.refresh_body=grant_type=refresh_token&refresh_token=\$refresh_token" \
  --data "config.content_type=application/x-www-form-urlencoded"
```

## Cara Kerja

### Flow Normal:
```
Client Request → Kong Gateway
                 ↓
         [token-manager-v2 :access]
         - Ambil token dari Redis (atau config)
         - Set Authorization header
                 ↓
         → Upstream Service
                 ↓
         ← 200 OK Response
                 ↓
         [token-manager-v2 :response]
         - Tidak ada action (status bukan 401)
                 ↓
         → Client
```

### Flow saat Token Expired:
```
Client Request → Kong Gateway
                 ↓
         [token-manager-v2 :access]
         - Gunakan token lama dari Redis
         - Set Authorization header
                 ↓
         → Upstream Service
                 ↓
         ← 401 Unauthorized
                 ↓
         [token-manager-v2 :response]
         - Deteksi status 401
         - Panggil refresh endpoint
         - Simpan token baru ke Redis
         - Teruskan respons 401 ke client
                 ↓
         → Client (menerima 401)
         
Client Retry → Kong Gateway
                 ↓
         [token-manager-v2 :access]
         - Ambil TOKEN BARU dari Redis ✅
         - Set Authorization header
                 ↓
         → Upstream Service
                 ↓
         ← 200 OK Response ✅
                 ↓
         → Client
```

## Fitur Tambahan

### Manual Token Clearing

Kirim header `Clear-Redis-Token: clear` untuk menghapus token yang tersimpan:

```bash
curl -X GET http://kong-gateway:8000/api/endpoint \
  -H "Clear-Redis-Token: clear" \
  -H "apikey: your-api-key"
```

## Migration dari V1

Untuk migrasi dari `token-manager` v1 ke v2:

1. **Install plugin V2** di service baru atau test environment dulu
2. **Konfigurasi sama persis** seperti V1 (schema-nya kompatibel)
3. **Test** dengan beberapa request
4. **Update service lama** setelah yakin V2 bekerja dengan baik

```bash
# Update existing plugin
curl -X PATCH http://kong-admin:8001/plugins/{plugin-id} \
  --data "name=token-manager-v2"
```

## Troubleshooting

**📖 Untuk panduan lengkap troubleshooting, lihat [DEBUGGING.md](./DEBUGGING.md)**

### Quick Checks:

#### Plugin tidak mengambil token baru
```bash
# Cek apakah token refresh berhasil
docker logs kong-gateway 2>&1 | grep "\[Refresh Token\] ✅"

# Cek apakah ada error
docker logs kong-gateway 2>&1 | grep "FAILED"
```

#### Redis connection error
```bash
# Test Redis connection
docker exec kong-gateway redis-cli -h kong-redis ping

# Cek keys di Redis
docker exec kong-redis redis-cli keys "*"
```

#### Token tidak tersimpan
```bash
# Lihat proses store token
docker logs kong-gateway 2>&1 | grep "\[Store Token\]"

# Lihat semua Redis operations
docker logs kong-gateway 2>&1 | grep "\[Redis\]"
```

#### Debug Mode
Enable debug logging untuk detail maksimal:
```yaml
# docker-compose.yml
environment:
  - KONG_LOG_LEVEL=debug
```

Kemudian reload Kong:
```bash
docker exec kong-gateway kong reload
```

## Logging

Plugin menggunakan level logging berikut dengan **prefix yang jelas** untuk debugging:

### Log Prefixes:
- `[Redis]` - Redis operations
- `[Store Token]` - Token storage
- `[Get Token]` - Token retrieval  
- `[Clear Tokens]` - Token clearing
- `[Substitute]` - Token substitution
- `[Refresh Token]` - Token refresh process
- `[Access Phase]` - Request access phase
- `[Response Phase]` - Response handling phase

### Log Levels:
- `debug`: Detail operasi (hanya untuk development)
- `info`: Operasi penting dengan ✅ indicator untuk success
- `warn`: Warning dengan ⚠️ indicator
- `err`: Error dengan ❌ indicator dan "FAILED" keyword

### Melihat Logs:

```bash
# Semua logs
docker logs kong-gateway -f

# Hanya plugin V2
docker logs kong-gateway 2>&1 | grep "token-manager-v2\|\[Access Phase\]\|\[Response Phase\]\|\[Refresh Token\]"

# Hanya errors
docker logs kong-gateway 2>&1 | grep "FAILED\|❌\|ERROR"

# Hanya success operations
docker logs kong-gateway 2>&1 | grep "✅\|Successfully"

# Filter per komponen
docker logs kong-gateway 2>&1 | grep "\[Refresh Token\]"
docker logs kong-gateway 2>&1 | grep "\[Redis\]"
```

### Example Log Output:

**Normal Request:**
```
[Access Phase] ========== Starting Access Phase ==========
[Access Phase] Service: procurement-service
[Get Token] Successfully retrieved token from Redis - Key: procurement-service:access_token - Length: 856 chars
[Access Phase] Using access token from Redis
[Access Phase] ✅ Access phase complete - Token injected
```

**Token Refresh:**
```
[Response Phase] ⚠️  Detected 401 Unauthorized - Token may be expired
[Refresh Token] ========== Starting Token Refresh Process ==========
[Refresh Token] Making HTTP request to: http://auth-service/login
[Refresh Token] Received response - Status: 200
[Refresh Token] ✅ Successfully received new tokens
[Store Token] Successfully stored token in Redis - Key: procurement-service:access_token
[Response Phase] ✅ Token refreshed successfully
```

**Error Scenario:**
```
[Refresh Token] FAILED to make refresh request - Error: connection timeout
[Refresh Token] FAILED - Unexpected status code: 401
[Get Token] FAILED to connect to Redis
```

**📖 Lihat [DEBUGGING.md](./DEBUGGING.md) untuk panduan lengkap troubleshooting!**

## License

Same as Kong Gateway

## Author

edoaurahman@gmail.com

## Version

2.0.0 - Fixed critical bugs from v1
